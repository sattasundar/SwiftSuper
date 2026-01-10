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

## 🏗️ Create a New Mini App

Follow these steps to create and integrate a new feature module.

### 1. Create a Swift Package
**Option A: Terminal (Fastest)**
Create a new folder in `Packages/` (e.g., `Packages/MyFeature`) and initialize a Swift Package:
```bash
cd Packages
mkdir MyFeature && cd MyFeature
swift package init --type library
```

**Option B: Xcode Interface**
1.  Go to **File > New > Package...**.
2.  Name it `MyFeature`.
3.  For **Save As**, navigate to the `Packages/` folder in your project directory.
4.  Click **Create**.
5.  Drag the new `Packages/MyFeature` folder from Finder into the Xcode Project Navigator (under the main file list). This adds it as a Local Package.

### 2. Add Core Data Dependency
Edit `Packages/MyFeature/Package.swift` to depend on **Core**:

```swift
dependencies: [
    .package(url: "https://github.com/sattasundar/Core.git", branch: "master")
],
targets: [
    .target(
        name: "MyFeature",
        dependencies: ["Core"]
    )
]
```

### 3. Implement the Protocol
In your package source, conform to `MiniApp`:

```swift
import SwiftUI
import Core

public class MyFeatureMiniApp: MiniApp {
    public let id = "com.satsang.myfeature"
    public let name = "My Feature"
    public let icon = "star.fill" // SF Symbol

    public init() {}

    public func makeRootViewController() -> UIViewController {
        return UIHostingController(rootView: MyFeatureView())
    }
}
```

### 4. Link Package to Host App
1.  Open **SwiftSuper.xcodeproj**.
2.  Select the **SwiftSuper** target.
3.  Go to **Build Phases** > **Link Binary With Libraries**.
4.  Click `+`.
5.  Select `MyFeature` (it should appear if the package is in the file list).
    *   *Note: If it's a GitHub repo, add it via File > Packages > Add Package Dependency first.*

### 5. Register in Host App
Open `SwiftSuper/MiniAppManager.swift` and register your new app:

```swift
private init() {
    register(BooksMiniApp())
    register(PrayerTimeMiniApp())
    register(MyFeatureMiniApp()) // <-- Add this
    // Ensure you add 'import MyFeature' at the top of the file!
}
```

---

## 🔄 Convert Existing App to Mini App

Yes, you can convert an existing application into a package, but it is a **manual refactoring process**. You cannot just "save as package".

Here is the high-level process to convert an existing app (e.g., "OldApp") into a Mini App Package:

### 1. Create the Package Shell
Create a new package (e.g., `Packages/OldAppFeature`) just like before using the CLI or Xcode.

### 2. Move Source Code
*   **Move Files**: Drag all your `.swift` files (Views, ViewModels, Models, Helpers) from the old Xcode Project into the `Sources/OldAppFeature` folder of your new package.
*   **Excluded Files**: Do **NOT** move `AppDelegate.swift`, `SceneDelegate.swift`, `Info.plist`, or `.entitlements`. These belong to the **Host App**, not the library.

### 3. Handle Resources
*   **Images/Colors**: Move your `Assets.xcassets` into `Sources/OldAppFeature/Resources`.
*   **Update Manifest**: In `Package.swift`, tell SwiftPM about the resources:
    ```swift
    .target(
        name: "OldAppFeature",
        dependencies: ["Core"],
        resources: [.process("Resources")] // <-- Important
    )
    ```
*   **Code Update**: Any code loading images like `Image("Logo")` needs to be updated to specify the bundle: `Image("Logo", bundle: .module)`.

### 4. Public Access Control (The Hardest Part)
*   By default, everything in your old app was likely `internal` (no keyword).
*   In a package, these are **invisible** to the Host App.
*   You must go through your code and mark the **Entry View** and any public APIs as `public`.

    ```swift
    // Before
    struct OldAppMainView: View { ... }

    // After
    public struct OldAppMainView: View { 
        public init() {} 
        ... 
    }
    ```

### 5. Conform to MiniApp
Finally, implement the `MiniApp` protocol in a new file inside the package.

---

## 🤝 Contribution
1.  **Mini Apps**: Work strictly within the `Packages/` directory.
2.  **Core Updates**: Push changes to the `Core` repo and update the version/branch reference in `Package.swift`.
3.  **UI Guidelines**: Use `SystemGroupedBackground` for base layers and `SystemBackground` (White/Black) for content cards.

---

## 📄 License
Copyright © 2026 Swift SuperApp. All rights reserved.
