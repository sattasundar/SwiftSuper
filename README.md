# Swift SuperApp

A modular iOS Super App built with **SwiftUI** and **Swift Package Manager**, demonstrating a micro-frontend architecture for native iOS development.

## 🚀 Application Overview

**Swift SuperApp** serves as a lightweight Host Application that integrates independent "Mini Apps" into a unified experience. It uses a core protocol to define interactions between the main app and its modular features.

### Key Features
- **Modular Architecture**: Features are split into standalone Swift Packages (`Books`, `PrayerTime`).
- **Dynamic Tab Navigation**: A custom `TabView` implementation that dynamically loads registered Mini Apps.
- **Light Theme Dashboard**: Clean, modern UI designed with standard iOS components.
- **Shared Core**: A unified contract (`Core` package) ensuring consistency across all modules.

---

## 📦 Modules

### 1. **SwiftSuper (Host App)**
The main container application. It manages:
- App Lifecycle.
- `MiniAppManager` registry.
- Global Navigation (`ContentView`).
- Dependency Injection.

### 2. **Core** (Library)
*   **Repository**: [https://github.com/sattasundar/Core.git](https://github.com/sattasundar/Core.git)
*   The backbone of the architecture. Defines the `MiniApp` protocol and shared strict types.
*   **Status**: Remote Dependency (Branch: `master`).

### 3. **Books** (Mini App)
A complete library feature module.
*   **Tech**: SwiftUI, LazyVGrid.
*   **Features**: Displays a curated grid of book covers with titles and prices.

### 4. **PrayerTime** (Mini App)
A dashboard for tracking daily prayer schedules.
*   **Tech**: SwiftUI, Charts/Shapes.
*   **Design**: Modern dashboard with Morning/Evening summary cards and a monthly forecast table.

---

## 🛠 Setup & Installation

### Prerequisites
- Xcode 14.0+ (iOS 16.0+ SDK)
- Swift 5.7+
- GitHub Account (for private package access)

### Installation
1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/sattasundar/SwiftSuper.git
    cd SwiftSuper
    ```

2.  **Open in Xcode**:
    Double-click `SwiftSuper.xcodeproj`.

3.  **Resolve Dependencies**:
    *   Xcode should automatically fetch the remote `Core` package.
    *   If you see missing package errors, go to `File > Packages > Reset Package Caches`.

### Project Structure
```text
SwiftSuper/
├── SwiftSuper.xcodeproj   # Main Project
├── SwiftSuper/            # Host App Source
└── Packages/              # Local Development Packages
    ├── Books/             # Books Mini App
    └── PrayerTime/        # PrayerTime Mini App
```

---

## 🤝 Contribution
1.  **Mini Apps**: Work strictly within the `Packages/` directory.
2.  **Core Updates**: Push changes to the `Core` repo and update the version/branch reference in `Package.swift`.
3.  **UI Guidelines**: Use `SystemGroupedBackground` for base layers and `SystemBackground` (White/Black) for content cards.

---

## 📄 License
Copyright © 2026 Swift SuperApp. All rights reserved.
