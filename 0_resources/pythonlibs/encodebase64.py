import base64

def encode_base_64_string(data):
    return base64.b64encode(bytes(data, 'utf-8'))
