import requests

############# Sensors Methods ##############
url = 'http://localhost:3000/api/webhook'
# url = 'https://sensor-network-lora.herokuapp.com/api/webhook'

dataRegister = {"hub.mode": "subscribe", "hub.challenge": "1817199792", "hub.verify_token": "LapupaExtrema", "id": "api"} 

# response = requests.get(url, json=data)
# print(">>> tx:", data)
# print(">>> rx:", response.json())


dataMessage = {"object": "page", "entry": [{"id": "228020030589534", "time": 1600635198308, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1600635198194, "message": {"mid": "m_7n8EfeRR1GRh_FPtTNDpDN8fA-Kv-hhLSzY2oIj9lgvCa70NViMnq7Qgn5S_fKx6Rt4paJw8VrA2Oh9eJtX1cw", "text": "Subscribe"}}]}], "webhook": {"object": "page", "entry": [{"id": "228020030589534", "time": 1600635198308, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1600635198194, "message": {"mid": "m_7n8EfeRR1GRh_FPtTNDpDN8fA-Kv-hhLSzY2oIj9lgvCa70NViMnq7Qgn5S_fKx6Rt4paJw8VrA2Oh9eJtX1cw", "text": "Subscribe"}}]}]}}

dataMessageRandom = {"object": "page", "entry": [{"id": "228020030589534", "time": 1600636103316, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1600636103216, "message": {"mid": "m_zHW2ixxFGmYe-Oc1ImyE6N8fA-Kv-hhLSzY2oIj9lgsl8TTUZjd-1byOPYpsfYBmkaCkK7eHDHSsPG4RV6WC1g", "text": "CommonMessage"}}]}], "webhook": {"object": "page", "entry": [{"id": "228020030589534", "time": 1600636103316, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1600636103216, "message": {"mid": "m_zHW2ixxFGmYe-Oc1ImyE6N8fA-Kv-hhLSzY2oIj9lgsl8TTUZjd-1byOPYpsfYBmkaCkK7eHDHSsPG4RV6WC1g", "text": "CommonMessage"}}]}]}}

dataFromSubsYes = {"object": "page", "entry": [{"id": "228020030589534", "time": 1600638255195, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1600638255066, "postback": {"title": "Yes!", "payload": "subs-yes"}}]}], "webhook": {"object": "page", "entry": [{"id": "228020030589534", "time": 1600638255195, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1600638255066, "postback": {"title": "Yes!", "payload": "subs-yes"}}]}]}}

dataFromSubsNo = {"object": "page", "entry": [{"id": "228020030589534", "time": 1600638255195, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1600638255066, "postback": {"title": "No", "payload": "subs-no"}}]}], "webhook": {"object": "page", "entry": [{"id": "228020030589534", "time": 1600638255195, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1600638255066, "postback": {"title": "No", "payload": "subs-yes"}}]}]}}

dataFromDev = {"object": "page", "entry": [{"id": "228020030589534", "time": 1600638255195, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1600638255066, "postback": {"title": "Yes!", "payload": "dev-14"}}]}], "webhook": {"object": "page", "entry": [{"id": "228020030589534", "time": 1600638255195, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1600638255066, "postback": {"title": "Weather Station 1", "payload": "dev-1"}}]}]}}

dataFromSen = {"object": "page", "entry": [{"id": "228020030589534", "time": 1600638255195, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1600638255066, "postback": {"title": "Yes!", "payload": "sen-17"}}]}], "webhook": {"object": "page", "entry": [{"id": "228020030589534", "time": 1600638255195, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1600638255066, "postback": {"title": "Weather Station 1", "payload": "dev-1"}}]}]}}


transmit = dataFromSubsNo
transmit = dataMessageRandom
transmit = dataFromSubsYes
transmit = dataFromDev
transmit = dataFromSen
response = requests.post(url, json = transmit)
print(">>> tx:", transmit)
print(">>> rx:", response)