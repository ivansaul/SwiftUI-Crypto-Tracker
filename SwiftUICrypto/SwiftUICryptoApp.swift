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
    @State private var showLounchView: Bool = true

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.theme.accent)
        ]
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(Color.theme.accent)
        ]
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .environmentObject(homeVM)
                ZStack {
                    if showLounchView {
                        LounchView(showLounchView: $showLounchView)
                            .transition(.opacity)
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
