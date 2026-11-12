import xml.etree.ElementTree as ET
from data import PROFILE

def dict_to_xml(tag, data):
    element = ET.Element(tag)
    for key, value in data.items():
        if isinstance(value, dict):
            element.append(dict_to_xml(key, value))
        elif isinstance(value, list):
            group = ET.SubElement(element, key)
            for item in value:
                ET.SubElement(group, "item").text = str(item)
        else:
            ET.SubElement(element, key).text = str(value)
    return element

root = dict_to_xml("profile", PROFILE)
raw = ET.tostring(root, encoding="utf-8")
print("=== XML ===")
print(raw.decode("utf-8"))
print("Размер:", len(raw), "байт")
parsed = ET.fromstring(raw)
print("Имя пользователя:", parsed.findtext("name"))
