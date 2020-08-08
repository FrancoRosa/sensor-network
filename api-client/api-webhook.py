import requests

############# Sensors Methods ##############
url = 'http://localhost:3000/api/sensors'
# url = 'https://sensor-network-lora.herokuapp.com/api/sensors'

data = {"hub.mode": "subscribe", "hub.challenge": "1817199792", "hub.verify_token": "LapupaExtrema", "id": "api"} 

response = requests.get(url, json=data)
print(">>> tx:", data)
print(">>> rx:", response.json())
