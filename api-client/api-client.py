from time import sleep
import requests
url = 'http://localhost:3000/api/'
sensors = url + 'sensors'
actuators = url + 'actuators'

oldtoken = -1

while True:
  # If sensor data received
  # Update sensors
  # data={'sensor': {'id': [3, 4, 5], 'value': [1.11, 2.22, 3.33 ]}} #many sensors
  # check if there is new updated data

  response = requests.get(actuators, json={}).json()
  if oldtoken != response.get('token'):
    print("oldtoken", oldtoken)
    oldtoken = response.get('token')
    # read actuator expected values
    actuatorstatus = requests.get(actuators, json={'actuator': {'id': []}}).json()
    print actuatorstatus
  
  sleep(5)
  