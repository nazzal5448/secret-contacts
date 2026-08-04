# 🔐 Secret Contacts

[![Play Store](https://img.shields.io/badge/Google_Play-Secret_Contacts-green?style=for-the-badge&logo=google-play)](https://play.google.com/store/apps/details?id=com.nbk.secret_contacts)
[![Maintainer Site](https://img.shields.io/badge/Developer-mylarbags.co.uk-blue?style=for-the-badge)](https://mylarbags.co.uk)

**Secret Contacts** is a privacy-focused, cross-platform mobile application designed to securely store and manage sensitive contact information away from standard, unencrypted address books. Built using **Flutter**, **Riverpod**, and **Hive**.

---

## 📲 App Availability & Web Extensions

### 📱 Mobile App
- **Google Play Store**: [Get Secret Contacts on Android](https://play.google.com/store/apps/details?id=com.nbk.secret_contacts)

### 🧩 Web & Browser Extensions (Fonts Extractor)
- **Google Chrome**: [Chrome Web Store](https://chromewebstore.google.com/detail/fonts-extractor/ibanfpdophidapkefgoljedldkbdfhbp)
- **Mozilla Firefox**: [Firefox Add-ons](https://addons.mozilla.org/en-US/firefox/addon/fonts-extractor/)
- **Microsoft Edge**: [Microsoft Edge Add-ons](https://microsoftedge.microsoft.com/addons/detail/ofhlgnjkekiaidppkifalpjcafcplfil)

---

## ✨ Features

- 🔑 **Master PIN & Biometric Security**: Secure entry using a customized PIN or native device biometrics (fingerprint/face recognition).
- 🗂️ **Encrypted Local Storage**: Contacts, phone numbers, emails, addresses, and notes are securely stored on-device using Hive and Flutter Secure Storage.
- ⭐ **Favorites Management**: Pin key confidential contacts for instant access.
- 🎨 **Modern Dark Mode Interface**: Modern UI built with Flutter, optimized for speed, clarity, and visual privacy.
- 📦 **Data Management**: Export backups or perform a complete, permanent vault wipe whenever needed.

---

## 🛠️ Tech Stack & Architecture

- **Framework**: [Flutter](https://flutter.dev/) (Dart)
- **State Management**: [Flutter Riverpod](https://riverpod.dev/) & Riverpod Annotations
- **Routing**: [GoRouter](https://pub.dev/packages/go_router)
- **Local Vault**: [Hive](https://pub.dev/packages/hive) & [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)
- **Biometrics**: [Local Auth](https://pub.dev/packages/local_auth)
- **Animations**: [Flutter Animate](https://pub.dev/packages/flutter_animate)

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (`^3.11.4` or compatible)
- Android Studio / Xcode for mobile emulation or device deployment

### Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/nazzal5448/secret-contacts.git
   cd secret-contacts
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run code generation (if modifying models):**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

---

## 🌐 Developer & Maintainer

Maintained and developed by **[mylarbags.co.uk](https://mylarbags.co.uk)**.
