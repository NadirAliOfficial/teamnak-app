# TeamNAK Mobile App

Official Flutter mobile app for [TeamNAK](https://theteamnak.com) — Smart Tech. Real Impact.

## Features

- **Home** — Hero section with animated count-up stats (300+, 100%, 4.9★) and client testimonials
- **Products** — Grid of all products pulled from the live API with images
- **Services** — List of all services with cover images
- **Blog** — All blog posts with cover images and summaries
- **Contact** — Direct links to all social platforms and a CTA card

## Tech Stack

- **Flutter** — Cross-platform mobile framework
- **http** — API calls to the TeamNAK backend
- **cached_network_image** — Efficient image loading and caching
- **google_fonts** — Poppins font matching the website
- **url_launcher** — Opens links in browser/apps

## Backend API

All data is fetched from the live TeamNAK REST API:
```
https://web-back-ywoz.onrender.com/api
```

Endpoints used: `/products` · `/services` · `/blogs` · `/testimonials`

## Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0`
- Android Studio / Xcode

### Run

```bash
git clone https://github.com/NadirAliOfficial/teamnak-app.git
cd teamnak-app
flutter pub get
flutter run
```

### Build

```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release
```

## Project Structure

```
lib/
├── main.dart                 # App entry, theme, bottom nav
├── screens/
│   ├── home_screen.dart      # Hero + animated stats + testimonials
│   ├── products_screen.dart
│   ├── services_screen.dart
│   ├── blog_screen.dart
│   └── contact_screen.dart
├── services/
│   └── api_service.dart      # All API calls
└── widgets/
    ├── skeleton.dart          # Skeleton loading animations
    └── gradient_text.dart     # Green→blue→purple gradient text
```

## Connect

| Platform | Link |
|---|---|
| Website | [theteamnak.com](https://theteamnak.com) |
| LinkedIn | [Nadir Ali Khan](https://www.linkedin.com/in/teamnadiralikhan) |
| GitHub | [NadirAliOfficial](https://github.com/NadirAliOfficial) |
| Telegram | [@NAKBlockDev](https://t.me/NAKBlockDev) |
| Fiverr | [nadiralikhan786](https://www.fiverr.com/nadiralikhan786) |

---

&copy; 2026 Team NAK. All rights reserved.
