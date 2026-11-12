# Практическая работа №3 — Форматы данных

Проект реализует сравнение JSON, XML, YAML, MessagePack, CBOR и Protobuf,
а также передачу сериализованных данных по TCP и демонстрацию схемной эволюции.

## Состав
- `data.py` — исходный профиль данных.
- `step_json.py`, `step_xml.py`, `step_yaml.py` — текстовые форматы.
- `step_msgpack.py`, `step_cbor.py`, `step_protobuf.py` — бинарные форматы.
- `profile.proto`, `profile_pb2.py` — схема и Python-модуль Protobuf.
- `server.py`, `client.py` — TCP-сервер и клиент.
- `schema_evolution.py` — чтение старых данных новой схемой.
- `run_all.py` — сравнительная таблица размеров.
- `report/Отчет.md` — основа отчёта.

## Установка
```bash
python -m pip install -r requirements.txt
```

## Запуск тестов
Из каталога `date_format`:
```bash
python step_json.py
python step_xml.py
python step_yaml.py
python step_msgpack.py
python step_cbor.py
python step_protobuf.py
python run_all.py
python schema_evolution.py
```

## TCP-тест
Откройте два терминала в каталоге `date_format`.

Терминал 1:
```bash
python server.py
```
Терминал 2:
```bash
python client.py
```
В `client.py` меняйте `FMT` на `msgpack`, `cbor`, `protobuf`; перед каждым запуском
клиента сервер должен быть готов принимать следующее подключение (он работает в цикле).

Файлы принятых сообщений сохраняются в `received/`.

## Отчёт и скриншоты
Заполните `report/Отчет.md` результатами фактического запуска программ.
Скриншоты из своей консоли добавьте в `screenshots/`. Не подставляйте вымышленные
размеры или результаты проверок.
