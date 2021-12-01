//
//  WTbetaApp.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/14/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct WTbetaApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    
//    var body: some Scene {
//        WindowGroup {
//            LaunchView()
//        }
//    }
    
    var body: some Scene {
        WindowGroup {
            CustomLaunchView()
                .environmentObject(UserVM())
        }
    }
}
