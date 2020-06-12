import requests
# Read all the sensors
url = 'http://localhost:3000/api/sensors'
response = requests.get(url)
print ">>>>>>>> Sensors"
print response.json()

# Read all the actuators
url = 'http://localhost:3000/api/actuators'
response = requests.get(url)
print ">>>>>>>> Actuators"
print response.json()

# Read selected sensors
data={'id': [3] }
url = 'http://localhost:3000/api/sensors'
response = requests.get(url, json=data)
print ">>>>>>>> Selected Sensors"
print response.json()

# Read selected sensors
data={'id': [1] }
url = 'http://localhost:3000/api/actuators'
response = requests.get(url, json=data)
print ">>>>>>>> Selected Actuators"
print response.json()
