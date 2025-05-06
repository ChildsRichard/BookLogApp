//
//  BookLogApp.swift
//  BookLog
//
//  Created by Richard Childs on 4/9/25.
//

import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth




@main
struct BookLogApp: App {
    @StateObject private var bookStore = BookStore()

    
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    class AppDelegate: NSObject, UIApplicationDelegate {
      func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
          

        return true
      }
    }


    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
        .environmentObject(bookStore)    }
}
