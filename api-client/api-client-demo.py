import requests

############# Sensors Methods ##############
# url = 'http://localhost:3000/api/sensors'
# url = 'https://sensor-network-lora.herokuapp.com/api/sensors'



# Read sensors
# data={'sensor': {'id': [3, 4, 5]}} #many sensors
# data={'sensor': {'id': [3]}} #only one
# data={'sensor': {'id': []}} #all sensors

# Update sensors
# data={'sensor': {'id': [17], 'value': [10]}} #many one sensor
# data={'sensor': {'id': [3, 4, 5], 'value': [1.11, 2.22, 3.33 ]}} #many sensors

# response = requests.get(url, json=data)
# print(">>> tx:", data)
# print(">>> rx:", response.json())

############# Actuators Methods ##############
url = 'http://localhost:3000/api/actuators'
#url = 'https://sensor-network-lora.herokuapp.com/api/actuators'
# Read Actuators
# data={'actuator': {'id': [1, 2, 3]}} #many actuators
data={'actuator': {'id': [10]}} #only one
# data={'actuator': {'id': []}} #read all actuators
# data={} #t read token to see new changes

# Update Actuators
# data={'actuator': {'id': [3], 'expected_status': [0]}} #many actuators
# data={'actuator': {'id': [1,2,3], 'expected_status': [9.99, 10.11, 11.22 ]}} #many actuators


############# Device Methods ##############
# url = 'http://localhost:3000/api/devices'
# url = 'https://sensor-network-lora.herokuapp.com/api/actuators'
# Read Actuators
# data={'devices': {'id': [1, 2, 3]}} #many devicess
# data={'devices': {'id': [15]}} #many devicess
# data={'devices': {'id': [3]}} #only one
# data={'devices': {'id': []}} #all sensors
# data={} #all sensors

# Update device data
# data={'devices': {'id': 14, 'data':{'latitude': -13.0, 'longitude': -71.0}}} #many devicess


# Show results
response = requests.get(url, json=data)
print(">> url:", url)
print(">>> tx:", data)
print(">>> rx:", response.json())
