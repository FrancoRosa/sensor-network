# serial connection
from helpers import *
connectionPort = '/dev/pts/3'
import serial
ser = serial.Serial(connectionPort)  # open serial port

#gateway
keys = {'connection': 'secret'}
conected_devices = []
# receive packects
# if there is a conection packed, add device to queries
# send its configuration parameters to the conected device


def registerDevice(command):
  if keys['connection'] in incomeCommand:
    newDeviceID = incomeCommand.strip().replace(keys['connection'], '')
    print('>>> New Device Connected:', id)
    # Look for config details on database
    # TXPeriod, TXSlot, RXTime

while True:
  incomeCommandBytes = ser.readline()
  incomeCommand = bytes2str(incomeCommandBytes)
  print(incomeCommand)
  registerDevice(incomeCommand)