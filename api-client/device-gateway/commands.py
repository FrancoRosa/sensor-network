import json

comm_key     = '_key_'
comm_connect = '_conect_'
comm_ack     = '_ack_'
comm_device  = '_device_'
comm_sensor  = '_sensor_'
comm_actuator= '_actuator_'


def frame_builder(deviceID, command, values = []):
  return comm_key+deviceID+command+json.dumps(values)

def get_id(frame):
  if comm_key in frame:
    return frame.split('_')[2]
  else:
    return False

print(frame_builder('22',comm_ack))
print(get_id(frame_builder('22',comm_ack)))

