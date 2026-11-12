import json
import xml.etree.ElementTree as ET
from pathlib import Path
import yaml
import msgpack
import cbor2
import profile_pb2
from data import PROFILE

def to_xml(data):
    root = ET.Element("profile")
    for key, value in data.items():
        if isinstance(value, dict):
            child = ET.SubElement(root, key)
            for subkey, subvalue in value.items():
                ET.SubElement(child, subkey).text = str(subvalue)
        elif isinstance(value, list):
            group = ET.SubElement(root, key)
            for item in value:
                ET.SubElement(group, "item").text = str(item)
        else:
            ET.SubElement(root, key).text = str(value)
    return ET.tostring(root, encoding="utf-8")

p = profile_pb2.Profile()
p.id, p.name, p.age = PROFILE["id"], PROFILE["name"], PROFILE["age"]
p.is_student = PROFILE["is_student"]
p.courses.extend(PROFILE["courses"])
p.address.city = PROFILE["address"]["city"]
p.address.zip = PROFILE["address"]["zip"]

results = [
    ("JSON", json.dumps(PROFILE, ensure_ascii=False).encode("utf-8"), "Да", "Нет"),
    ("XML", to_xml(PROFILE), "Да", "Нет"),
    ("YAML", yaml.safe_dump(PROFILE, allow_unicode=True).encode("utf-8"), "Да", "Нет"),
    ("MessagePack", msgpack.packb(PROFILE, use_bin_type=True), "Нет", "Нет"),
    ("CBOR", cbor2.dumps(PROFILE), "Нет", "Нет"),
    ("Protobuf", p.SerializeToString(), "Нет", "Да"),
]
print(f"{'Формат':<14} {'Размер (байт)':>14} {'Читаем?':>10} {'Схема?':>9}")
print("-" * 52)
for name, raw, readable, schema in results:
    print(f"{name:<14} {len(raw):>14} {readable:>10} {schema:>9}")

out = Path(__file__).resolve().parent / "received"
out.mkdir(exist_ok=True)
report = [{"format": name, "size_bytes": len(raw),
           "human_readable": readable, "schema_required": schema}
          for name, raw, readable, schema in results]
(out / "report.json").write_text(
    json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8"
)
print("\nJSON-отчёт сохранён в received/report.json")
