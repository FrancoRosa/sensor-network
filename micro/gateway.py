import requests

from time import sleep, time
import serial
url = 'http://localhost:3000/api/'
# url = 'https://sensor-network-lora.herokuapp.com/api/'

port = '/dev/ttyS20'
key = 'secret'
debug = True
commands = {
  'connect': 'connect',
  'config': 'config',
  'readings': 'readings',
}

# Listen to all connections all the time
ser = serial.Serial(port, timeout=5)

def listen():
  message = ser.readline()
  if message: 
    message = str(message.decode('utf-8'))
    if debug: print('< -- ' + message) 
    return message
  return ''

def get_id(message):
  message = message.strip("b'")
  message = message.replace(key, '')
  message = message.replace(commands['connect'],'')
  try:
    device_id = int(message)
    return device_id
  except:
    pass

def get_device_config(device_id):
  route='devices'
  data={'devices': {'id': [device_id]}}
  response = requests.get(url+route, json=data)
  return response.json()

def communicate(tx_data):
  if debug: print('-- > '+tx_data) 
  ser.write(tx_data.encode('utf-8'))

def send_config(device_id, config):

  # sync sets the remaining seconds for the next transmission windown
  # time(): Seconds from the epoch
  # sync = tx_period - round(time())%tx_period
  frame = '%s%s%s,%s,%s,%s,%d\n\r'%(
    key,
    str(device_id),
    commands['config'],
    config[0]['tx_period'],
    config[0]['tx_slot'],
    config[0]['rx_time'],
    round(time())%config[0]['tx_period'],
  )
  if debug: print('frame:', frame)
  communicate(frame)

def save_readings(message):
  message = message.strip()
  message = message.replace(key,'')
  message = message.replace(commands['readings'],'')
  message = message.split(',')
  device_id = int(message[0])

  sensors_values = message[1:]
  
  route = 'devices'
  
  data={'devices': {'id': [device_id], 'sensors':[]}}
  response = requests.get(url+route, json=data)
  sensors_id = response.json()
  
  data={'devices': {'id': [device_id], 'actuators':[]}}
  response = requests.get(url+route, json=data)
  actuators_id = response.json()

  print('sensor_ids:', sensors_id)
  print('sensor_values:', sensors_values)
  
  route = 'sensors'
  data={'sensor': {'id': sensors_id, 'value': list(map(float,sensors_values[:len(sensors_id)]))}}
  response = requests.get(url+route, json=data)
  print(">>> rx:", response.json())
  
  route = 'actuators'
  data={'actuator': {'id': actuators_id, 'current_status': list(map(float,sensors_values[:len(sensors_id)]))}}
  response = requests.get(url+route, json=data)
  print(">>> rx:", response.json())

# connected_devices = {} --S Thread to check timeouts(every 10seg)
# connected_devices = {} --S Thread to db changes(20s)
# thread to get actuator updates (every sec)
# thread to manage serial stuff
# thread to send I am alive data every min

connected_devices = []

while True:
  message = listen()
  if commands['connect'] in message:
    device_id = get_id(message)
    config = get_device_config(device_id)
    send_config(device_id, config)
    
    if not device_id in connected_devices:
      connected_devices.append(device_id)
  
  if commands['readings'] in message:
    save_readings(message)
  
  #look for changes on server

# DB Gateway
# name
# 
# last record (Conection, disconections, update)

#Gateway-devices

#Gateway api to asociate or not