from pathlib import Path
import shutil

def main():
    desktop = Path.home() / "Desktop"
    stand = desktop / "Учебный_стенд"

    if stand.exists():
        print(f"Папка уже существует: {stand}")
        print("Во избежание потери данных ничего не изменено.")
        return

    docs = stand / "Мои_документы"
    backup = stand / "backup"
    temp = stand / "Temp"
    docs.mkdir(parents=True)
    backup.mkdir()
    temp.mkdir()

    samples = {
        "Документ1.txt": "Учебный текстовый документ.\n",
        "Заметки.txt": "Пример пользовательских заметок.\n",
        "Таблица.csv": "Товар,Количество\nКнига,3\nРучка,10\n",
        "Отчёт.html": "<!doctype html><html><body><h1>Учебный отчёт</h1></body></html>\n",
        "Изображение.svg": '<svg xmlns="http://www.w3.org/2000/svg" width="200" height="100"><rect width="200" height="100" fill="lightblue"/><text x="10" y="55">Учебное изображение</text></svg>\n',
        "Список.txt": "Первый пункт\nВторой пункт\n",
    }

    for name, content in samples.items():
        (docs / name).write_text(content, encoding="utf-8")

    for file in docs.iterdir():
        shutil.copy2(file, backup / file.name)

    for number, file in enumerate(list(docs.iterdir()), start=1):
        file.rename(docs / f"sample{number:02d}.locked")

    note = """Ваши файлы зашифрованы!
Это учебная имитация. Не переводите деньги и не отправляйте письма.
"""
    (stand / "README_DECRYPT.txt").write_text(note, encoding="utf-8")

    # Пустые файлы-заглушки: они не являются исполняемыми вредоносными программами.
    for name in ("svchost.exe", "update.tmp", "run.bat"):
        (temp / name).write_bytes(b"")

    print(f"Учебный стенд создан: {stand}")
    print("Содержимое:")
    for item in sorted(stand.rglob("*")):
        if item.is_file():
            print(f"  {item.relative_to(stand)}")
    print("\nЭто только безопасная имитация. Не запускайте файлы из Temp.")

if __name__ == "__main__":
    main()
