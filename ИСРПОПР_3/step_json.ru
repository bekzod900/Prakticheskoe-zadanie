import json
from data import PROFILE

raw = json.dumps(PROFILE, ensure_ascii=False, indent=2).encode("utf-8")
print("=== JSON ===")
print(raw.decode("utf-8"))
print("Размер:", len(raw), "байт")
restored = json.loads(raw.decode("utf-8"))
assert restored == PROFILE
print("Десериализация успешна:", restored["name"])
