"""Демонстрация обратной совместимости Protobuf."""
import profile_pb2
from data import PROFILE

# Создаём бинарные данные по старому набору полей (email не заполняем).
old = profile_pb2.Profile()
old.id = PROFILE["id"]
old.name = PROFILE["name"]
old.age = PROFILE["age"]
old.is_student = PROFILE["is_student"]
old.courses.extend(PROFILE["courses"])
old.address.city = PROFILE["address"]["city"]
old.address.zip = PROFILE["address"]["zip"]
old_bytes = old.SerializeToString()

# Новая схема читает старые данные; добавленное поле email остаётся пустым.
new = profile_pb2.Profile()
new.ParseFromString(old_bytes)
print("Имя:", new.name)
print("Email (новое поле):", repr(new.email))
