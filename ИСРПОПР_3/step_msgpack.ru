import msgpack
from data import PROFILE

raw = msgpack.packb(PROFILE, use_bin_type=True)
print("=== MessagePack ===")
print("HEX:", raw.hex())
print("Размер:", len(raw), "байт")
restored = msgpack.unpackb(raw, raw=False)
assert restored == PROFILE
print("Десериализация успешна:", restored["name"])
