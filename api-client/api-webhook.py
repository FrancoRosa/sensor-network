import requests

############# Sensors Methods ##############
url = 'http://localhost:3000/api/sensors'
# url = 'https://sensor-network-lora.herokuapp.com/api/sensors'

data = {"hub.mode": "subscribe", "hub.challenge": "1817199792", "hub.verify_token": "secret-token", "id": "api"} 

postdata = {"object": "page", "entry": [{"id": "228020030589534", "time": 1597026033055, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1597026032796, "message": {"mid": "m_-EeroIlpDfl5r78vfCL9O98fA-Kv-hhLSzY2oIj9lgvzhgaRt2eg5R3mqQCO9wuxvjFM1nIKvt0Cm_Q5n5usTw", "text": "Yoyooyoyoyobro!"}}]}], "sensor": {}}

postdata = {"object": "page", "entry": [{"id": "228020030589534", "time": 1597027772581, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1597027772409, "message": {"mid": "m_kLmrtW7tnwW-Fo-Wvy15f98fA-Kv-hhLSzY2oIj9lgviwRQ5PQg0QuaHdi6xtPDPuIa6SXSaGoyKrkYrevftKA", "text": "ZZZZZZZZZZZZZZZ"}}]}], "sensor": {}}

response = requests.post(url, json=postdata)
print(">>> tx:", data)
print(">>> rx:", response.content)
