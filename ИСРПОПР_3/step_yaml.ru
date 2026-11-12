import yaml
from data import PROFILE

raw = yaml.safe_dump(PROFILE, allow_unicode=True, sort_keys=False).encode("utf-8")
print("=== YAML ===")
print(raw.decode("utf-8"))
print("Размер:", len(raw), "байт")
restored = yaml.safe_load(raw.decode("utf-8"))
assert restored == PROFILE
print("Десериализация успешна:", restored["name"])
