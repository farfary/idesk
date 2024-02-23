//
//  iDeskApp.swift
//  iDesk
//
//  Created by Farhad Arghavan on 2024-02-23.
//

import SwiftUI
import SwiftData


class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidBecomeActive(_ notification: Notification) {   
    }
}



@main
struct iDeskApp: App {
    static let logger = AppLogger()
    static let shared: iDeskApp = iDeskApp()
    static var fDevices:[FDevice] = []
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

   
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
//                    NSApp.hide(nil)
                    
                }
        }
        .modelContainer(sharedModelContainer)
        .defaultPosition(.center)
        .commands {
            
        }
    }

}

