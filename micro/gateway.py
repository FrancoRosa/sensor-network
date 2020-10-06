import requests

from time import sleep, time
import serial
url = 'http://localhost:3000/api/devices'
# url = 'https://sensor-network-lora.herokuapp.com/api/actuators'

port = '/dev/ttyS20'
key = 'secret'
debug = True
commands = {
  'connect': 'connect',
  'config': 'config',
  'readings': 'readings',
}


# Listen to all connections all the time
ser = serial.Serial(port)

def listen():
  message = ser.readline()
  if message: 
    message = str(message.decode('utf-8'))
    if debug: print('< -- ' + message) 
    return message

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
  data={'devices': {'id': [device_id]}}
  response = requests.get(url, json=data)
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
    config[0]['tx_period'] - round(time())%config[0]['tx_period'],
  )
  if debug: print('frame:', frame)
  communicate(frame)

def save_readings(message):
  message = message.replace(commands[readings],'')
  try:
    device_id = int(message)
    return device_id
  except:
    pass

while True:
  message = listen()
  
  if commands['connect'] in message:
    device_id = get_id(message)
    config = get_device_config(device_id)
    send_config(device_id, config)
  
  if commands['readings'] in message:
    save_readings(message)