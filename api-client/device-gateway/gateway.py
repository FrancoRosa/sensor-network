import requests

#server connection
url = 'http://localhost:3000/api/devices'
deviceData = {'devices': {'id': [0]}}

# serial connection
from helpers import *
from commands import *
connectionPort = '/dev/pts/5'
import serial
ser = serial.Serial(connectionPort)  # open serial port
print(ser.name)         # check which port was really used

#gateway
conected_devices = []
# receive packects
# if there is a conection packed, add device to queries
# send its configuration parameters to the conected device


def registerDevice(command):
  if comm_key in incomeCommand:
    newDeviceID = get_id(incomeCommand)
    print('>>> New Device Connected:', newDeviceID)
    response = requests.get(url, json=deviceData)
    response = response.json()
    
    if len(response) == 0:
      message = frame_builder(newDeviceID, comm_device,'Device %s not found'%newDeviceID)
      print(message)
      ser.write(str2bytes(message))
    else:
      conected_devices.append(newDeviceID)
      message = frame_builder(newDeviceID, comm_device, response)
      print(response)
    ser.write(str2bytes(message))


while True:
  incomeCommandBytes = ser.readline()
  incomeCommand = bytes2str(incomeCommandBytes)
  print(incomeCommand)
  registerDevice(incomeCommand)