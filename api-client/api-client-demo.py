import requests

############# Sensors Methods ##############
url = 'http://localhost:3000/api/sensors'

# Read sensors
# data={'sensor': {'id': [3, 4, 5]}} #many sensors
# data={'sensor': {'id': [3]}} #only one
# data={'sensor': {'id': []}} #all sensors
# response = requests.get(url, json=data)

# print(">>>tx:", data)
# print(">>>rx:", response.json())

# Update sensors
# data={'sensor': {'id': [3], 'value': [0]}} #many sensors
# data={'sensor': {'id': [3,4,5], 'value': [9.99, 10.11, 11.22 ]}} #many sensors
# response = requests.get(url, json=data)

# print(">>>tx:", data)
# print(">>>rx:", response.json())

############# Actuators Methods ##############
url = 'http://localhost:3000/api/actuators'
# Read Actuators
# data={'actuator': {'id': [1, 2, 3]}} #many actuators
# data={'actuator': {'id': [3]}} #only one
# data={'actuator': {'id': []}} #all sensors
# response = requests.get(url, json=data)

# print(">>>tx:", data)
# print(">>>rx:", response.json())

# Update Actuators
data={'actuator': {'id': [3], 'expected_status': [0]}} #many actuators
data={'actuator': {'id': [1,2,3], 'expected_status': [9.99, 10.11, 11.22 ]}} #many actuators
response = requests.get(url, json=data)

print(">>>tx:", data)
print(">>>rx:", response.json())