import UIKit
import React
import React_RCTAppDelegate

class AppDelegate: RCTAppDelegate {
    static var shared: AppDelegate?
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Self.shared = self
        self.automaticallyLoadReactNativeWindow = false
        self.moduleName = "SwiftSuper"
        self.initialProps = [:]
        
        // Trigger background check for updates
        BundleManager.shared.checkForUpdates { updated in
            if updated {
                print("🚀 [OTA] Update downloaded. Restart the app to apply.")
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // Disable Bridgeless mode to fix "RCTEventEmitter" errors with certain native modules
    // This enables "Hybrid" mode (Fabric + Bridge)
    override func bridgelessEnabled() -> Bool {
        return false
    }
    
    override func sourceURL(for bridge: RCTBridge!) -> URL! {
        // 1. Check for OTA update first
        if let otaBundle = BundleManager.shared.activeBundleURL() {
            return otaBundle
        }
        
        // 2. Fallback to Metro (Debug) or Built-in Bundle (Release)
        return self.bundleURL()
    }
    
    override func bundleURL() -> URL? {
        #if DEBUG
            return RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
        #else
            return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
        #endif
    }
}
