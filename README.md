# Smart Agriculture App

A comprehensive Flutter application designed to assist farmers with smart agriculture solutions, including crop management, sensor monitoring, and AI-powered assistance.

## Features

- **Authentication**: Secure login with demo credentials.
- **Home Dashboard**: 
  - Welcome greeting with "My Farm View" placeholder.
  - Quick overview cards for Soil Moisture, Temperature, and NPK Levels.
- **Sensor Monitoring**: 
  - Detailed real-time visualization with progress bars.
  - Live status indicators for Nitrogen, Phosphorus, and Potassium.
- **AI Chatbot Assistant**: 
  - Interactive chat interface.
  - Quick option chips for common queries (Crop Disease, Weather, etc.).
  - Auto-reply simulation for demo purposes.
- **Crop Recommendations**: 
  - AI-driven crop suggestions based on soil data.
  - detailed match score and requirements (Rice, Maize, Groundnut).
- **Settings & Localization**: 
  - Toggle-able alerts for Weather, Water, Crops, etc.
  - **Multi-language Support**: Options for English, Hindi, and Telugu.
  - Profile and Farm details management.
- **Accessibility**: 
  - dedicated Accessibility floating button.
  - Options for **Large Text**, **High Contrast**, and **Screen Reader**.
- **UI/UX**: 
  - Consistent pastel green agriculture theme (`#2E7D32`).
  - Ease-of-use focus for farmers with large touch targets.

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
