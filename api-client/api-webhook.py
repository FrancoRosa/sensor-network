import requests

############# Sensors Methods ##############
url = 'http://localhost:3000/api/webhook'
# url = 'https://sensor-network-lora.herokuapp.com/api/sensors'

# data = {"hub.mode": "subscribe", "hub.challenge": "1817199792", "hub.verify_token": "LapupaExtrema", "id": "api"} 

# response = requests.get(url, json=data)
# print(">>> tx:", data)
# print(">>> rx:", response.json())
 data = {"object": "page", "entry": [{"id": "228020030589534", "time": 1600634095814, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1600622122686, "message": {"mid": "m_-nS01eYb6fJZQjwmn0A2KN8fA-Kv-hhLSzY2oIj9lgvmcQnByN-2F9Q_Tu141DyNsZTFtuWd-F3g8nbC8QOCOw", "text": "d"}}]}], "webhook": {"object": "page", "entry": [{"id": "228020030589534", "time": 1600634095814, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1600622122686, "message": {"mid": "m_-nS01eYb6fJZQjwmn0A2KN8fA-Kv-hhLSzY2oIj9lgvmcQnByN-2F9Q_Tu141DyNsZTFtuWd-F3g8nbC8QOCOw", "text": "d"}}]}]}}

 response = requests.post(url, json=data)
print(">>> tx:", data)
print(">>> rx:", response.json())