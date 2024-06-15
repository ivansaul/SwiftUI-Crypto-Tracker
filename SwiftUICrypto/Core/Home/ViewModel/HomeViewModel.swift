//
//  HomeViewModel.swift
//  SwiftUICrypto
//
//  Created by saul on 6/8/24.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []

    @Published var searchText: String = ""

    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.allCoins.append(DeveleperPreview.instance.coin)
        self.allCoins.append(DeveleperPreview.instance.coin)
        self.portfolioCoins.append(DeveleperPreview.instance.coin)
        self.addSubscribers()
    }

    private func addSubscribers() {
        self.$searchText
            .combineLatest(self.dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchSerialQueue.main)
            .map { text, startingCoins in
                if text.isEmpty {
                    return startingCoins
                }
                let lowecaseText = text.lowercased()

                return startingCoins.filter { coin in
                    coin.name.contains(lowecaseText)
                        || coin.id.contains(lowecaseText)
                        || coin.symbol.contains(lowecaseText)
                }
            }
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &self.cancellables)
    }
}
