# QuantAI 🚀

QuantAI is a premium, AI-powered cryptocurrency portfolio management and market tracking application built with Flutter. It combines real-time data streaming, advanced AI financial analysis, and seamless portfolio management in a stunning modern interface.

## ✨ Features

- **📊 Real-Time Market Tracking**: Stream live data for top cryptocurrencies via the CoinGecko API.
- **🤖 AI Financial Assistant**: Get deep insights and technical analysis from an integrated AI chat interface.
- **💼 Advanced Portfolio Management**: Track your assets, view cost-basis, and monitor real-time profit/loss.
- **💰 Real Financials**: Persistent wallet balance (USD) for managing deposits and withdrawals.
- **🎨 Premium UI/UX**: Dark mode by default, glassmorphism aesthetics, and smooth micro-animations.
- **🔒 Secure Authentication**: Integrated with Supabase for robust and reliable user authentication.

## 📸 Screenshots

| Dashboard | AI Chat Assistant |
| :---: | :---: |
| ![Dashboard](docs/screenshots/dashboard.png) | ![AI Chat](docs/screenshots/chat.png) |

## 🛠 Tech Stack

- **Framework**: [Flutter](https://flutter.dev) (Dart)
- **Backend**: [Supabase](https://supabase.com) (Auth & Data)
- **Local Database**: [Drift](https://drift.simonbinder.eu) (SQLite for persistence)
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it) & [injectable](https://pub.dev/packages/injectable)
- **Networking**: [Retrofit](https://pub.dev/packages/retrofit) & [Dio](https://pub.dev/packages/dio)
- **Real-time Data**: CoinGecko API

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- A Supabase account and project

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/USER_NAME/quant_ai.git
   cd quant_ai
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure Environment**:
   Create a file at `lib/config/env.dart` and add your Supabase credentials:
   ```dart
   class Env {
     static const String supabaseUrl = 'YOUR_SUPABASE_URL';
     static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
   }
   ```

4. **Generate Code**:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the App**:
   ```bash
   flutter run
   ```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Built with ❤️ by [Your Name]
