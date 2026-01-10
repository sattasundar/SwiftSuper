import SwiftUI
import Core

struct ContentView: View {
    let miniApps = MiniAppManager.shared.registeredApps
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            // Tab 1: Books
            if let booksApp = miniApps.first(where: { $0.id == "com.satsang.books" }) {
                NavigationStack {
                    MiniAppWrapper(miniApp: booksApp)
                }
                .tabItem {
                    Label(booksApp.name, systemImage: booksApp.icon)
                }
            }
            
            // Tab 2: Prayer Time
            if let prayerApp = miniApps.first(where: { $0.id == "com.satsang.prayertime" }) {
                NavigationStack {
                    MiniAppWrapper(miniApp: prayerApp)
                }
                .tabItem {
                    Label(prayerApp.name, systemImage: prayerApp.icon)
                }
            }
        }
    }
}

struct MiniAppWrapper: UIViewControllerRepresentable {
    let miniApp: MiniApp
    
    func makeUIViewController(context: Context) -> UIViewController {
        return miniApp.makeRootViewController(params: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No updates needed
    }
}

#Preview {
    ContentView()
}
