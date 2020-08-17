import requests

############# Sensors Methods ##############
url = 'http://localhost:3000/api/sensors'
# url = 'https://sensor-network-lora.herokuapp.com/api/sensors'

data = {"hub.mode": "subscribe", "hub.challenge": "1817199792", "hub.verify_token": "secret-token", "id": "api"} 

postdata = {"object": "page", "entry": [{"id": "228020030589534", "time": 1597080979563, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1597080979370, "message": {"mid": "m_0Yye8o2G-9SmuTP6X0nXgN8fA-Kv-hhLSzY2oIj9lgu-p1fnTBj912-tyJMZf9W18js3zpHue3ouSK78P7U1qg", "attachments": [{"type": "location", "payload": {"coordinates": {"lat": -13.536134, "long": -71.953647}, "url": "https://l.facebook.com/l.php?u=https%3A%2F%2Fwww.bing.com%2Fmaps%2Fdefault.aspx%3Fv%3D2%26pc%3DFACEBK%26mid%3D8100%26where1%3D-13.536134%252C%2B-71.953647%26FORM%3DFBKPL1%26mkt%3Des-MX&h=AT0_FRUH2Zw8aW7nLA_jj0HvuaeMi_2tuRJ2ACy1mcKnmHjCrhXVEidKNshUuFp4thavcs7LPOeMp_YT-YfsLLQSlHsK7mmDZGHqxFvcrZjYrQKIFQIeqwxg2ddCPZxEZVYGMccCM3IPVUg&s=1", "title": "Pinned Location"}}]}}]}], "sensor": {}}

postdata = {"object": "page", "entry": [{"id": "228020030589534", "time": 1597026033055, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1597026032796, "message": {"mid": "m_-EeroIlpDfl5r78vfCL9O98fA-Kv-hhLSzY2oIj9lgvzhgaRt2eg5R3mqQCO9wuxvjFM1nIKvt0Cm_Q5n5usTw", "text": "Yoyooyoyoyobro!"}}]}], "sensor": {}}

postdata = {"object": "page", "entry": [{"id": "228020030589534", "time": 1597027772581, "messaging": [{"sender": {"id": "3142169012485474"}, "recipient": {"id": "228020030589534"}, "timestamp": 1597027772409, "message": {"mid": "m_kLmrtW7tnwW-Fo-Wvy15f98fA-Kv-hhLSzY2oIj9lgviwRQ5PQg0QuaHdi6xtPDPuIa6SXSaGoyKrkYrevftKA", "text": "ZZZZZZZZZZZZZZZ"}}]}], "sensor": {}}

response = requests.post(url, json=postdata)
print(">>> tx:", data)
print(">>> rx:", response.content)
