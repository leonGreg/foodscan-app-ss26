# FoodScan

A Flutter mobile application for scanning food product barcodes and analysing their nutritional quality. FoodScan retrieves product data from the **Open Food Facts** database and presents NutriScore, Eco-Score, NOVA processing level, additives, allergens, and a custom **FoodScan Score** — a single 0–100 rating that combines all individual scores into one easy-to-read number.

## Group Members

- Florian Jafar Sabonchi – 5123008
- Leon Greger – 6123049
- Denys Khlystun – 2507543
- Islam Elsayed – 5122132

---

## Screenshots

TODO

---

## Features

- **Barcode scanning** — camera-based EAN-13 / EAN-8 detection via `flutter_zxing`, with a manual entry fallback
- **Product details** — NutriScore, Eco-Score, NOVA group, ingredients, allergens, additives with risk levels, full nutrient table
- **FoodScan Score** — custom 0–100 score combining NutriScore, Eco-Score, NOVA group, additive risk, and organic certification (see below)
- **Scan history** — every scanned product is saved per-user in Firestore; the home screen shows a paginated, infinite-scrolling history list
- **Search** — debounced full-text product search with separate pagination
- **Authentication** — email/password sign-up, login, password reset, and profile editing via Firebase Auth
- **Light / Dark theme** — toggle in the app header; preference is persisted across sessions via SharedPreferences
- **Multilingual** — English, German, and Finnish localisations

---

## Setup & Run

**Requirements**

- Flutter SDK `^3.11.0` (Dart `^3.11.0`)
- Android emulator or physical Android device (min SDK 21)

**Clone & install dependencies**

```bash
git clone <your-repo-url>
cd mobile_applications_project_ss26
flutter pub get
```

**Firebase**

Firebase is pre-configured — no additional setup required.
`android/app/google-services.json` and `lib/firebase_options.dart` are committed and point to the project's Firebase backend (Authentication + Cloud Firestore).

> **Note:** The app targets **Android**. iOS is not supported in this submission.

**Run**

```bash
flutter run
```

**Tests**

```bash
flutter test
```

## Main Packages

| Package | Why |
|---|---|
| `flutter_bloc ^9.1.1` | BLoC state management — one Bloc/Event/State per feature |
| `go_router ^17.2.3` | Declarative named-route navigation with auth-redirect guards |
| `firebase_auth ^5.3.4` | Email/password authentication |
| `cloud_firestore ^5.6.3` | Persistent per-user scan history |
| `openfoodfacts ^3.30.2` | Open Food Facts API client (product data, nutrition, scores) |
| `flutter_zxing ^2.3.0` | Camera-based EAN-13 / EAN-8 barcode scanning |
| `cached_network_image ^3.4.1` | Efficient loading and caching of product images from URLs |
| `skeletonizer ^2.1.3` | Skeleton loading placeholders while data is fetched |
| `shared_preferences ^2.3.3` | Persists the user's light/dark theme preference across sessions |
| `intl ^0.20.2` | Internationalisation (English, German, Finnish) |
| `equatable ^2.0.8` | Value equality for BLoC states and models |
| `flutter_widget_from_html_core ^0.15.1` | Renders HTML ingredient/additive descriptions from the API |