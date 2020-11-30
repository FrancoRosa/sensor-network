from time import sleep, time
from os import uname
import requests
import serial
import re

rpi = False

if uname()[1] == 'raspberrypi':
  rpi = True
  ledpin = 13
  import RPi.GPIO as GPIO
  GPIO.setmode(GPIO.BCM)
  GPIO.setwarnings(False)
  GPIO.setup(ledpin, GPIO.OUT)

# url = 'http://localhost:3000/api/'
url = 'https://sensor-network-lora.herokuapp.com/api/'

port = '/dev/ttyUSB0'
if rpi: port = '/dev/ttyS0'

key = 'lora'
debug = True
commands = {
  'connect': 'connect',
  'config': 'config',
  'readings': 'readings',
  'ack': 'ack',
}

connected_devices = {}
# Listen to all connections all the time
ser = serial.Serial(port, timeout=.98)

def listen():
  message = ser.readline()
  try:
    if message: 
      message = str(message.decode('utf-8'))
      if debug: print('< -- ' + message) 
      if key in message:
        return message
  except:
    pass
  return ''

def get_id(message):
  device_id = re.findall(r'\d+', message)[0]
  try:
    device_id = int(device_id)
    return device_id
  except:
    return 0

def get_device_config(device_id):
  route='devices'
  data={'devices': {'id': [device_id]}}
  response = requests.get(url+route, json=data)
  return response.json()

def communicate(tx_data):
  if debug: print('-- > '+tx_data) 
  ser.write(tx_data.encode('utf-8'))

def send_config(device_id, config):
  # sync sets the remaining seconds for the next transmission window
  # time(): Seconds from the epoch
  # sync = round(time())%tx_period
  frame = '%s%s%s,%s,%s,%s,%d\n\r'%(
    key,
    str(device_id),
    commands['config'],
    config[0]['tx_period'],
    config[0]['tx_slot'],
    config[0]['rx_time'],
    round(time())%config[0]['tx_period'],
  )
  # if debug: print('frame:', frame)
  communicate(frame)

def get_ids(device_id):
  data={'devices': {'id': [device_id], 'sensors':[]}}
  response = requests.get(url+'devices', json=data)
  sensors_id = response.json()
  
  data={'devices': {'id': [device_id], 'actuators':[]}}
  response = requests.get(url+'devices', json=data)
  actuators_id = response.json()
  return sensors_id, actuators_id

def get_actuators(actuators_id):
  data={'actuator': {'id': [actuators_id]}}
  response = requests.get(url+'actuators', json=data)
  actuators_status = response.json()
  return actuators_status

def get_data(message):
  message = message.strip()
  message = message.replace(key,'')
  message = message.replace(commands['readings'],'')
  message = message.split(',')
  device_id = int(message[0])
  values = message[1:]
  print('>>>>>>>>>>>>')
  print(values)
  print('>>>>>>>>>>>>')
  return device_id, values

def send_data(values, sensors_id, actuators_id):
  route = 'sensors'
  data={'sensor': {'id': sensors_id, 'value': list(map(float,values[:len(sensors_id)]))}}
  response = requests.get(url+route, json=data)
  # print(">>> rx:", response.json())
  
  route = 'actuators'
  data={'actuator': {'id': actuators_id, 'current_status': list(map(float,values[len(sensors_id):]))}}
  response = requests.get(url+route, json=data)
  # print(">>> rx:", response.json())

def send_ack(device_id, actuators_status):
  sync = time()%connected_devices[device_id]['config']['tx_period']
  frame = '%s%d%s,%d,%s\n\r'%(
    key,
    device_id,
    commands['ack'],
    sync,
    ','.join(list(map(lambda a: str(round(a[1]*100)), actuators_status)))
  )
  # if debug: print('frame:', frame)
  communicate(frame)

def connect_device(device_id):
  config = get_device_config(device_id)
  if len(config) != 0:
    send_config(device_id, config)
    if not device_id in connected_devices:
      sensors_id, actuators_id = get_ids(device_id)
      connected_devices[device_id] = {
        'config': config[0],
        'sensors': sensors_id,
        'actuators': actuators_id
      }

def save_readings(message):
  device_id, values = get_data(message)
  if device_id in connected_devices:
    sensors_id = connected_devices[device_id]['sensors']
    actuators_id = connected_devices[device_id]['actuators']
    actuators_status = get_actuators(actuators_id)
    send_data(values, sensors_id, actuators_id)
    send_ack(device_id, actuators_status)
  else:
    connect_device(device_id)

def blink():
  if rpi:
    GPIO.output(ledpin, GPIO.HIGH)
    sleep(0.02)
    GPIO.output(ledpin, GPIO.LOW)


while True:
  blink()
  message = listen()
  if commands['connect'] in message:
    device_id = get_id(message)
    connect_device(device_id)
  
  if commands['readings'] in message:
    save_readings(message)
  