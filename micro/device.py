from time import sleep
import serial

port = '/dev/ttyS21'

key = 'secret'
debug = True

device = {
  'id': 14,
  'sync': 0, 
  'tx_connect': 15, 
  'tx_period': 30,
  'tx_slot': 7,
  'rx_time': 10,
}

commands = {
  'connect': 'connect',
  'config': 'config',
  'readings': 'readings',
}

sensors = ['1','2','3','4']

def communicate_reg(tx_data):
  ser = serial.Serial(port, timeout=device['rx_time'])
  if debug: print('-- > '+tx_data) 
  ser.write(tx_data.encode('utf-8'))
  message = ser.readline()
  message = str(message.decode('utf-8'))
  if message: print('< -- ' + message) 
  ser.close()
  return message

def update_config(message):
  message = message.strip("b'")
  message = message.replace(key, '')
  message = message.replace(commands['config'],'')
  message = message.split(',')
  if int(message[0])==device['id']:
    device['tx_period'] = int(message[1])
    device['tx_slot'] = int(message[2])
    device['rx_time'] = int(message[3])
    device['sync'] = int(message[4])
    return True
  else:
    return False

def connect_gateway():
  frame = '%s%s%s\n\r'%(key,str(device['id']),'connect')
  while True:
    message = communicate_reg(frame)
    if commands['config'] in message:
      return message
    else:
      sleep(device['tx_connect'] - device['rx_time'])

def send_data():
  flag_sent = False
  flag_rx = False
  rx_count = 0
  while True:
    if device['sync'] == 0:
      device['sync'] = device['tx_period']
      flag_sent = False

    if device['sync']%device['tx_slot'] == 0:
      if not flag_sent:
        ser = serial.Serial(port, timeout=0)
        frame = '%s%s%s,%s\n\r'%(
          key,
          device['id'],
          commands['readings'],
          ','.join(sensors))
        print('-- >', frame)
        ser.write(frame.encode('utf-8'))      
        flag_sent = True
        flag_rx = True
        rx_count = 0
        print('...listenig')
    
    if flag_rx:
      message = ser.read()
      message = message.decode('utf-8')
      if len(message) > 0:
        print(str(message)) 
      rx_count = rx_count + 1
      
    
    if rx_count >= device['rx_time']:
      print('...sleeping')
      rx_count = 0
      flag_rx=False
      ser.close()
    
    sleep(1)
    device['sync'] = device['sync'] - 1

      
    


while True:
  message = connect_gateway()
  if update_config(message):
    send_data()