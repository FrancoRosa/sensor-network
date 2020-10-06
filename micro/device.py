from time import sleep
import serial

port = '/dev/ttyS21'

key = 'secret'
debug = True
device = {
  'id': 17,
  'sync': 0, 
  'tx_connect': 15, 
  'tx_period': 30,
  'tx_slot': 7,
  'rx_time': 10,
}

frame = {
  'connection': '%s%s%s\n\r'%(key,str(device['id']),'connect')
}

def communicate(tx_data):
  ser = serial.Serial(port, timeout=device['rx_time'])
  if debug: print('-- > '+tx_data) 
  ser.write(tx_data.encode('utf-8'))
  message = ser.readline()
  message = str(message)
  if message: print('< -- ' + message) 
  ser.close()
  return message


while True:
  message = communicate(frame['connection'])
  if message:
    print('got it')
  else:
    sleep(device['tx_connect'] - device['rx_time'])