import Foundation

class BundleManager {
    static let shared = BundleManager()
    
    private let fileManager = FileManager.default
    private let bundlesDirectory: URL
    
    // Allow forcing a download for testing
    public var shouldMockDownload = false
    
    private init() {
        // Create a "Bundles" directory in Documents
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        bundlesDirectory = documentsURL.appendingPathComponent("Bundles")
        
        try? fileManager.createDirectory(at: bundlesDirectory, withIntermediateDirectories: true)
    }
    
    /// Returns the URL of the latest valid bundle on disk, or nil if none exists.
    func activeBundleURL() -> URL? {
        let latestBundleURL = bundlesDirectory.appendingPathComponent("index.bundle")
        if fileManager.fileExists(atPath: latestBundleURL.path) {
            print("[BundleManager] ✅ Found local OTA bundle at: \(latestBundleURL.path)")
            return latestBundleURL
        }
        print("[BundleManager] ℹ️ No local bundle found, using default.")
        return nil
    }
    
    /// Simulates downloading a bundle from a remote URL.
    /// In a real app, this would use URLSession to download a zip and unzip it.
    func checkForUpdates(completion: @escaping (Bool) -> Void) {
        // MOCK: In a real app, fetch from "https://api.myapp.com/latest-bundle"
        print("[BundleManager] 🔄 Checking for updates...")
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            
            // Logic: If we strictly want to test OTA, we can simulate a download
            // simply by copying the main bundle to the documents directory (for demo purposes)
            // or by downloading a real file if provided.
            
            if self.shouldMockDownload {
                print("[BundleManager] ⬇️ Mocking download of new bundle...")
                self.mockDownloadBundle()
                DispatchQueue.main.async {
                    completion(true) // Update found and applied
                }
            } else {
                print("[BundleManager] ✅ App is up to date.")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    private func mockDownloadBundle() {
        // DEMO: Copy the generated bundle from the app bundle to documents to simulate a "download"
        // In a real scenario, this 'downloaded' bundle would be different code (e.g., v2).
        guard let internalBundleURL = Bundle.main.url(forResource: "main", withExtension: "jsbundle") else {
            print("[BundleManager] ❌ Could not find internal bundle to copy.")
            return
        }
        
        let destinationURL = bundlesDirectory.appendingPathComponent("index.bundle")
        
        do {
            if fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.removeItem(at: destinationURL)
            }
            try fileManager.copyItem(at: internalBundleURL, to: destinationURL)
            print("[BundleManager] ✨ Mock update successful! Bundle saved to: \(destinationURL.path)")
        } catch {
            print("[BundleManager] ❌ Failed to mock update: \(error)")
        }
    }
    
    /// Clears the trusted local bundle to force a fallback to the built-in one.
    func resetFiles() {
        try? fileManager.removeItem(at: bundlesDirectory)
        try? fileManager.createDirectory(at: bundlesDirectory, withIntermediateDirectories: true)
        print("[BundleManager] 🗑️ Reset local bundles.")
    }
}
