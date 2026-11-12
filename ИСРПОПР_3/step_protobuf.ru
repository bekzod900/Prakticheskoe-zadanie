import profile_pb2
from data import PROFILE

p = profile_pb2.Profile()
p.id = PROFILE["id"]
p.name = PROFILE["name"]
p.age = PROFILE["age"]
p.is_student = PROFILE["is_student"]
p.courses.extend(PROFILE["courses"])
p.address.city = PROFILE["address"]["city"]
p.address.zip = PROFILE["address"]["zip"]

raw = p.SerializeToString()
print("=== Protobuf ===")
print("HEX:", raw.hex())
print("Размер:", len(raw), "байт")
restored = profile_pb2.Profile()
restored.ParseFromString(raw)
print("Десериализация успешна:", restored.name)
