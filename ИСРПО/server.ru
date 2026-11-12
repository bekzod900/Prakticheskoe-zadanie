import socket
import json
import threading

HOST = "localhost"
PORT_R = 9000
PORT_F = 9001


def handle_tcp_client(conn, addr):
    data = conn.recv(4096)
    try:
        message = json.loads(data.decode("utf-8"))
        print(f"[TCP] Получено от {addr}: {message}")
        response = {"status": "OK", "protocol": "TCP", "format": "JSON"}
    except (json.JSONDecodeError, UnicodeDecodeError):
        print(f"[TCP] Ошибка: не удалось разобрать JSON от {addr}")
        response = {"status": "ERROR", "reason": "invalid JSON"}

    conn.sendall(json.dumps(response, ensure_ascii=False).encode("utf-8"))
    conn.close()


def run_tcp_server():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server.bind((HOST, PORT_R))
    server.listen(5)
    print(f"[TCP] Сервер запущен на {HOST}:{PORT_R}")

    while True:
        conn, addr = server.accept()
        handle_tcp_client(conn, addr)


def run_udp_server():
    server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    server.bind((HOST, PORT_F))
    print(f"[UDP] Сервер запущен на {HOST}:{PORT_F}")

    while True:
        data, addr = server.recvfrom(4096)
        try:
            message = json.loads(data.decode("utf-8"))
            print(f"[UDP] Получено от {addr}: {message}")
            response = {"status": "OK", "protocol": "UDP", "format": "JSON"}
        except (json.JSONDecodeError, UnicodeDecodeError):
            print(f"[UDP] Ошибка: не удалось разобрать JSON от {addr}")
            response = {"status": "ERROR", "reason": "invalid JSON"}

        server.sendto(json.dumps(response, ensure_ascii=False).encode("utf-8"), addr)


if __name__ == "__main__":
    tcp_thread = threading.Thread(target=run_tcp_server, daemon=True)
    tcp_thread.start()
    run_udp_server()
