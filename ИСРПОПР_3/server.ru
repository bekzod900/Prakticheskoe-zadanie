import json
import socket
from pathlib import Path
import msgpack
import cbor2
import profile_pb2

HOST, PORT = "127.0.0.1", 9999
OUT = Path(__file__).resolve().parent / "received"
FORMATS = {b"J": "json", b"M": "msgpack", b"C": "cbor", b"P": "protobuf"}
EXT = {"json": "json", "msgpack": "msgpack", "cbor": "cbor", "protobuf": "pb"}

def recv_exact(conn, size):
    chunks = bytearray()
    while len(chunks) < size:
        part = conn.recv(size - len(chunks))
        if not part:
            raise ConnectionError("Соединение закрыто до получения всех данных")
        chunks.extend(part)
    return bytes(chunks)

def decode_payload(raw, fmt):
    if fmt == "json":
        return json.loads(raw.decode("utf-8"))
    if fmt == "msgpack":
        return msgpack.unpackb(raw, raw=False)
    if fmt == "cbor":
        return cbor2.loads(raw)
    if fmt == "protobuf":
        p = profile_pb2.Profile()
        p.ParseFromString(raw)
        return {"id": p.id, "name": p.name, "courses": list(p.courses),
                "email": p.email}
    raise ValueError("Неизвестный формат")

def main():
    OUT.mkdir(exist_ok=True)
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server:
        server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        server.bind((HOST, PORT))
        server.listen(5)
        print(f"Сервер слушает {HOST}:{PORT}...")
        while True:
            conn, addr = server.accept()
            with conn:
                try:
                    fmt_code = recv_exact(conn, 1)
                    fmt = FORMATS[fmt_code]
                    length = int.from_bytes(recv_exact(conn, 4), "big")
                    if length > 10_000_000:
                        raise ValueError("Слишком большой пакет")
                    raw = recv_exact(conn, length)
                    print(f"\n=== Получено {len(raw)} байт, формат: {fmt} ===")
                    print("HEX:", raw.hex())
                    try:
                        print("TEXT:", raw.decode("utf-8"))
                    except UnicodeDecodeError:
                        print("TEXT: <не текст, бинарные данные>")
                    print("DATA:", decode_payload(raw, fmt))
                    path = OUT / f"message_{fmt}.{EXT[fmt]}"
                    path.write_bytes(raw)
                    print(f"[СОХРАНЕНО] {path}")
                    conn.sendall(b"OK")
                except Exception as exc:
                    print("Ошибка обработки клиента:", exc)

if __name__ == "__main__":
    main()
