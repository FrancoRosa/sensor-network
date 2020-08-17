# serial connection
connectionPort = '/dev/pts/2'
import serial
ser = serial.Serial(connectionPort)  # open serial port
print(ser.name)         # check which port was really used

from time import sleep
# virtual device
# Features
keys = {'connection': 'secret'}
device = {'id': '21', }
while True: # look for gateway
  sleep(1)
  connectionString = keys['connection']+device['id']+'\r\n'
  print(connectionString) #send registration string
  ser.write(str.encode(connectionString))
ser.close()             # close port
