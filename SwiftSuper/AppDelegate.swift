import UIKit
import React
import React_RCTAppDelegate

class AppDelegate: RCTAppDelegate {
    static var shared: AppDelegate?
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Self.shared = self
        self.automaticallyLoadReactNativeWindow = false
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // Disable Bridgeless mode to fix "RCTEventEmitter" errors with certain native modules
    // This enables "Hybrid" mode (Fabric + Bridge)
    override func bridgelessEnabled() -> Bool {
        return false
    }
    
    override func sourceURL(for bridge: RCTBridge!) -> URL! {
        return self.bundleURL()
    }
    
    override func bundleURL() -> URL? {
        #if DEBUG
            return URL(string: "http://localhost:8081/index.bundle?platform=ios")
        #else
            return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
        #endif
    }
}
