import requests

from time import sleep, time
import serial
url = 'http://localhost:3000/api/'
# url = 'https://sensor-network-lora.herokuapp.com/api/'

port = '/dev/ttyUSB0'
key = 'secret'
debug = True
commands = {
  'connect': 'connect',
  'config': 'config',
  'readings': 'readings',
  'ack': 'ack',
}
connected_devices = []
# Listen to all connections all the time
ser = serial.Serial(port, timeout=5)

def listen():
  message = ser.readline()
  try:
    if message: 
      message = str(message.decode('utf-8'))
      if debug: print('< -- ' + message) 
      return message
  except:
    pass
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

  data={'actuator': {'id': [actuators_id]}}
  response = requests.get(url+'actuators', json=data)
  actuators_status = response.json()
  return sensors_id, actuators_id, actuators_status

def get_data(message):
  message = message.strip()
  message = message.replace(key,'')
  message = message.replace(commands['readings'],'')
  message = message.split(',')
  device_id = int(message[0])
  values = message[1:]
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
  frame = '%s%s%s,%s\n\r'%(
    key,
    str(device_id),
    commands['ack'],
    ','.join(list(map(lambda a: str(round(a[1]*100)), actuators_status)))
  )
  # if debug: print('frame:', frame)
  communicate(frame)

def save_readings(message):
  device_id, values = get_data(message)
  sensors_id, actuators_id, actuators_status = get_ids(device_id)
  
  # print('device_id:', device_id)
  # print('values:', values)
  # print('sensors_id:', sensors_id)
  # print('actuators_id:', actuators_id)
  # print('actuators_status:', actuators_status)
  
  send_data(values, sensors_id, actuators_id)
  send_ack(device_id, actuators_status)

# connected_devices = {} --S Thread to check timeouts(every 10seg)
# connected_devices = {} --S Thread to db changes(20s)
# thread to get actuator updates (every sec)
# thread to manage serial stuff
# thread to send I am alive data every min

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