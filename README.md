# Baraka Portfolio (Flutter)

A cross-platform portfolio viewer built with **Flutter**, following **Clean Architecture**, using **Bloc**, and simulating live market price updates. The app fetches a portfolio from a remote JSON endpoint and displays user balance and open investment positions, with real-time updates.

---

## 🚀 Features

- Fetches portfolio data from: [dummyjson.com](https://dummyjson.com/c/60b7-70a6-4ee3-bae8)
- Displays **Net Value**, **Profit/Loss (PnL)**, and **open positions**
- Simulates **live market prices** updating every second
- **Clean Architecture** with separation of concerns: `data`, `domain`, `presentation`
- **Bloc** state management with dependency injection using `get_it` + `injectable`
- Fully supports **English** and **Arabic** with RTL alignment
- Programmatic UI using Flutter widgets and slivers
- Unit and widget tests included for core logic and UI
- Centralized theme and formatting utilities

---

## 🧠 Architecture Summary

| Category               | Details                                                        |
|------------------------|----------------------------------------------------------------|
| Platform               | iOS, Android                                                   |
| Architecture           | Clean Architecture + Bloc                                      |
| State Management       | `flutter_bloc`                                                 |
| Dependency Injection   | `get_it` + `injectable`                                        |
| Live Price Simulation  | `Stream.periodic` with randomized updates                      |
| Layout System          | CustomScrollView + SliverPersistentHeader + SliverList         |
| Language Support       | English / Arabic + RTL support                                 |
| Localization           | Flutter `intl` + language toggle                               |
| Unit Testing           | `flutter_test`, `bloc_test`                                    |
| Data Source            | Remote JSON API                                                |
| Minimum SDK            | iOS 13.0+, Android API 21+                                     |

---

## 🧪 Bonus Task Implementation

A mock market simulator updates prices live every second:

- `lastTradedPrice` is randomized ±10%
- For each position:
  - `marketValue = quantity * lastTradedPrice`
  - `pnl = marketValue - cost`
  - `pnlPercentage = (pnl * 100) / cost`
- For portfolio balance:
  - `netValue = sum of marketValue`
  - `pnl = sum of all pnl`
  - `pnlPercentage = (pnl * 100) / totalCost`

---

## 🧩 Folder Structure

```text
lib/
│
├── core/                 # Core utilities, theming, formatters, error handling
│
├── data/                 # Data models, API services, DTOs
│
├── domain/              # Entities and use cases
│
├── presentation/
│   ├── bloc/             # Bloc/Cubit + Events/States
│   ├── widgets/          # Reusable UI components
│   └── pages/            # Screens and view composition
│
├── l10n/                # Localization files
├── injection.dart       # DI setup with get_it/injectable
└── main.dart            # App entry point
```

---

🔧 Running with Flavors
You can run the app in different environments using Flutter flavors.

✅ Android
To run the qa flavor:

```bash
flutter run --flavor qa -t lib/main.dart
```
To build an APK for the qa flavor:

```bash
flutter build apk --flavor qa -t lib/main.dart
```

🍏 iOS
For iOS, flavors are defined via schemes and build configurations in Xcode.

✅ To run the qa flavor on iOS:

```bash
flutter run --flavor qa -t lib/main.dart
```

To build for release:

```bash
flutter build ios --flavor qa -t lib/main.dart
```

⚠️ Note: You need to configure schemes and targets in your Xcode project to match the qa and production flavors. Make sure Runner-qa and Runner-production schemes exist and map correctly to the respective build configurations.

## 🧪 Tests

- Unit tests for formatters, entity logic, use cases
- Widget tests for rendering key views and state transitions

```bash
flutter test
```

---

## 📸 Screenshots

| Light Mode              | Dark Mode               |
|------------------------|-------------------------|
| ![flutter_light_en](https://github.com/user-attachments/assets/2c72b0a5-894b-4682-8fab-a17f61018d06) | ![flutter_dark_en](https://github.com/user-attachments/assets/e5a3830f-ab10-4d4e-b729-ccdfcfaa6adc) |
| ![flutter_light_ar](https://github.com/user-attachments/assets/ee333c62-f671-42b2-888a-c28119573c84) | ![flutter_dark_ar](https://github.com/user-attachments/assets/88db694d-7171-453e-8a37-96ca63687a89) |


Web-End (chrome)

<img width="1194" alt="chrome" src="https://github.com/user-attachments/assets/e3d3c21f-f8f6-4ea7-96e6-046a38ee1bd4" />


---

## 📦 Requirements

- Flutter 3.16+
- Dart 3.2+
- Xcode 15 / Android Studio Hedgehog+
- CocoaPods (for iOS)
- `flutter pub get`
- `flutter pub run build_runner build`

---

## ▶️ Getting Started

```bash
git clone https://github.com/your-repo/baraka-flutter.git
cd baraka-flutter
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

---

## 🎨 Theme

Fonts and color schemes are centralized via `AppTheme`, used consistently across components to ensure visual consistency and easy theming.

---

## 📝 License

**baraka-flutter** is available under the [MIT license](LICENSE).
