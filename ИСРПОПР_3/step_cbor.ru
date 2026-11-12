import cbor2
from data import PROFILE

raw = cbor2.dumps(PROFILE)
print("=== CBOR ===")
print("HEX:", raw.hex())
print("Размер:", len(raw), "байт")
restored = cbor2.loads(raw)
assert restored == PROFILE
print("Десериализация успешна:", restored["name"])
