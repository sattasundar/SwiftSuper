import UIKit
import Core
import React
import React_RCTAppDelegate

class OblationMiniApp: MiniApp {
    var id: String = "com.satsang.oblation"
    var name: String = "Oblation"
    var icon: String = "flame" // Suitable SF Symbol for Oblation
    
    func makeRootViewController(params: [String : Any]?) -> UIViewController {
        // Development: Load from Metro Bundler running in Packages/Oblation
        // Production: Load from local bundle file
        
        #if DEBUG
            let jsBundleURL = URL(string: "http://localhost:8081/index.bundle?platform=ios")!
        #else
             // Fallback to included bundle or logic to find downloaded bundle
             let jsBundleURL = Bundle.main.url(forResource: "main", withExtension: "jsbundle") ?? URL(string: "http://localhost:8081/index.bundle?platform=ios")!
        #endif
        
        // "Oblation" matches the name in index.js / app.json
        let moduleName = "Oblation"
        
        // Use the shared Host/Factory managed by AppDelegate (New Architecture)
        guard let appDelegate = AppDelegate.shared else {
            // In production, handle this gracefully or fallback
            fatalError("AppDelegate.shared is nil")
        }
        
        let rootView = appDelegate.rootViewFactory().view(withModuleName: moduleName, initialProperties: params, launchOptions: nil)

        
        let vc = UIViewController()
        vc.view = rootView
        return vc
    }
}
