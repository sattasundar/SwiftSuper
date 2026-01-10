import UIKit
import Core
import PrayerTime
import Books
// import ReactShim - REMOVED

class MiniAppManager {
    static let shared = MiniAppManager()
    
    // In a real app, this list might be populated dynamically or via configuration
    private(set) var registeredApps: [MiniApp] = []
    
    private init() {
        registerApps()
    }
    
    private func registerApps() {
        // Register known Mini Apps
        registeredApps.append(PrayerTimeMiniApp())
        registeredApps.append(BooksMiniApp())
        
        // Add more apps here as they are added to the workspace
        print("Registered \(registeredApps.count) mini apps.")
    }
}
//
//  MiniAppManager.swift
//  SwiftSuper
//
//  Created by Sattasundar.Parida on 10/01/26.
//

