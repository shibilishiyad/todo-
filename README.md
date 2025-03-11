# Todo App with Hive - Flutter

A simple and efficient to-do app built with Flutter, featuring local storage powered by Hive. Manage your tasks seamlessly with a clean and intuitive interface.

## 📂 Features

- 📝 **Task Management:** Add, edit, and delete tasks.
- 📦 **Local Storage with Hive:** Save tasks locally without an internet connection.
- 🌓 **Simple UI:** Minimalistic and responsive design.
- ✅ **Task Completion:** Mark tasks as complete or incomplete.

## 🛠️ Tech Stack

- **Flutter:** Frontend framework for building the app.
- **Hive:** NoSQL lightweight database for local storage.

## 🚀 Getting Started

1. **Clone the Repository:**

```bash
git clone https://github.com/shibilishiyad/todo-.git
cd todo_app
```

2. **Install Dependencies:**

```bash
flutter pub get
```

3. **Run the App:**

```bash
flutter run
```

## 🛠️ Setup Hive

Ensure Hive is set up properly:

```yaml
dependencies:
  hive: ^2.2.3
  hive_flutter: ^1.1.0

dev_dependencies:
  hive_generator: ^1.1.2
  build_runner: ^2.1.7
```

Initialize Hive in your app:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(MyApp());
}
```

## 📄 Folder Structure

```
lib/
├── main.dart
├── models/
├── screens/
├── widgets/
└── utils/
```



## 👤 Author

- **Shibili Shiyad** - [GitHub](https://github.com/shibilishiyad)




