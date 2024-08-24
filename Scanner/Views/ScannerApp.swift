//
//  ScannerApp.swift
//  Scanner
//
//  Created by Shirin-Yan on 22.08.2024.
//

import SwiftUI

@main
struct ScannerApp: App {
    @StateObject var coordinator = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path){
                LandingView()
                    .navigationDestination(for: Page.self) { page in
                        coordinator.view(for: page)
                    }
            }.environmentObject(coordinator)
        }
    }
}
