//
//  SwiftUICryptoApp.swift
//  SwiftUICrypto
//
//  Created by saul on 6/6/24.
//

import SwiftUI

@main
struct SwiftUICryptoApp: App {
    @StateObject private var homeVM = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(homeVM)
        }
    }
}
