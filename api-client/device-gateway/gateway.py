import requests

#server connection
url = 'http://localhost:3000/api/devices'
deviceData = {'devices': {'id': [0]}}

# serial connection
from helpers import *
connectionPort = '/dev/pts/5'
import serial
ser = serial.Serial(connectionPort)  # open serial port
print(ser.name)         # check which port was really used

#gateway
keys = {'connection': 'secret'}
conected_devices = []
# receive packects
# if there is a conection packed, add device to queries
# send its configuration parameters to the conected device


def registerDevice(command):
  if keys['connection'] in incomeCommand:
    newDeviceID = incomeCommand.strip().replace(keys['connection'], '')
    print('>>> New Device Connected:', newDeviceID)
    deviceData['devices']['id'] = newDeviceID
    response = requests.get(url, json=deviceData)
    response = response.json()
    if len(response) == 0:
      message = 'Device %s not found'%newDeviceID
      print(message)
      ser.write(str2bytes(message))
    else:
      conected_devices.append(newDeviceID)
      print(response)
      ser.write(str2bytes('Device %s found'%newDeviceID))


while True:
  incomeCommandBytes = ser.readline()
  incomeCommand = bytes2str(incomeCommandBytes)
  print(incomeCommand)
  registerDevice(incomeCommand)