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

dataTest = {"object": "page", "entry": [{"id": "228020030589534", "time": 1600652615925, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1600651132162, "message": {"mid": "m_WYK-raH64RJ-rTdBiCUCtN8fA-Kv-hhLSzY2oIj9lgvjAcYK3dK7hLxeeC-rNPFgei9daGuBBCJEoeqyUdmvBg", "attachments": [{"type": "image", "payload": {"url": "https://scontent.xx.fbcdn.net/v/t39.1997-6/cp0/39178562_1505197616293642_5411344281094848512_n.png?_nc_cat=1&_nc_sid=ac3552&_nc_ohc=l64-Yff2mrcAX9NQQa_&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=29559310c632efc16de729e8c19efa3c&oe=5F8DF5C9", "sticker_id": 369239263222822}}]}}]}], "webhook": {"object": "page", "entry": [{"id": "228020030589534", "time": 1600652615925, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1600651132162, "message": {"mid": "m_WYK-raH64RJ-rTdBiCUCtN8fA-Kv-hhLSzY2oIj9lgvjAcYK3dK7hLxeeC-rNPFgei9daGuBBCJEoeqyUdmvBg", "attachments": [{"type": "image", "payload": {"url": "https://scontent.xx.fbcdn.net/v/t39.1997-6/cp0/39178562_1505197616293642_5411344281094848512_n.png?_nc_cat=1&_nc_sid=ac3552&_nc_ohc=l64-Yff2mrcAX9NQQa_&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=29559310c632efc16de729e8c19efa3c&oe=5F8DF5C9", "sticker_id": 369239263222822}}]}}]}]}}

transmit = dataFromSubsNo
transmit = dataFromDev
transmit = dataMessageRandom
transmit = dataTest
transmit = dataFromSubsYes
transmit = dataFromSen
response = requests.post(url, json = transmit)
print(">>> tx:", transmit)
print(">>> rx:", response)