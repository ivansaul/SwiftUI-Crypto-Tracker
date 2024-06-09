//
//  HomeViewModel.swift
//  SwiftUICrypto
//
//  Created by saul on 6/8/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []

    init() {
        self.allCoins.append(DeveleperPreview.instance.coin)
        self.portfolioCoins.append(DeveleperPreview.instance.coin)
    }
}
