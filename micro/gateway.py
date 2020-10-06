from time import sleep

port = '/dev/ttyS20'
key = 'secret'

commands = {
  connect: 'connect'
}


# Listen to all connections all the time
ser = serial.Serial(port)

def listen()
  ser.readline()
  if message: 
    message = str(message)
    print('< -- ' + message) 
    return message

while True:
  message = listen()
  if 'connect' in message:
    #read server for data about device