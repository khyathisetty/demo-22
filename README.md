# Smart Agriculture App

A comprehensive Flutter application designed to assist farmers with smart agriculture solutions, including crop management, sensor monitoring, and AI-powered assistance.

## Features

- **Authentication**: Secure login with demo credentials.
- **Home Dashboard**: Overview of agricultural status.
- **Sensor Monitoring**: Real-time visualization of sensor data.
- **Crop Management**: Tools for tracking and managing crops.
- **Chatbot**: AI assistant for agricultural queries.
- **Settings**: Application configuration.

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Dart SDK (included with Flutter)
- Android Studio / VS Code / Xcode (for iOS)

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/smart-agriculture.git
    cd smart-agriculture
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the application:**
    ```bash
    flutter run
    ```

## Login Credentials (Demo)

Use the following credentials to log in to the application:

*   **Mobile Number:** `1234567890`
*   **Password:** `password`

## Project Structure

```
lib/
├── main.dart           # Entry point
├── screens/            # Application screens (Login, Home, Sensors, etc.)
├── theme/              # App theming and styling
└── widgets/            # Reusable UI components
```

## Development

- **State Management**: Uses `StatefulWidget` for local state.
- **Navigation**: Uses basic `Navigator` push/pop.
- **UI**: Custom theming with a focus on ease of use.

For more help with Flutter, check out the [online documentation](https://docs.flutter.dev/).
