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

    @Published var statistics: [StatisticModel] = []

    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.allCoins.append(DeveleperPreview.instance.coin)
        self.allCoins.append(DeveleperPreview.instance.coin)
        self.portfolioCoins.append(DeveleperPreview.instance.coin)
        self.addSubscribers()
    }

    private func addSubscribers() {
        // Updates allCoins
        self.$searchText
            .combineLatest(self.coinDataService.$allCoins)
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

        // Updates PortfolioCoins
        self.$allCoins
            .combineLatest(self.portfolioDataService.$savedEntities)
            .map { coinModels, portfolioEntities -> [CoinModel] in
                coinModels
                    .compactMap { coin in
                        guard let entity = portfolioEntities.first(where: { $0.coinId == coin.id }) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink(receiveValue: { returnedCoins in
                self.portfolioCoins = returnedCoins
            })
            .store(in: &self.cancellables)

        // Updates markedData
        self.marketDataService.$marketData
            .combineLatest(self.$portfolioCoins)
            .map(self.mapMarketData)
            .sink { [weak self] returnedStatistics in
                self?.statistics = returnedStatistics
            }
            .store(in: &self.cancellables)
    }

    func updatePorfolio(coin: CoinModel, amount: Double) {
        self.portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }

    private func mapMarketData(marketData: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []

        guard let data = marketData else {
            return stats
        }

        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, precentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)

        let portfolioValue = portfolioCoins.map { $0.currentHoldingsValue }.reduce(0, +)
        let previousPortfolioValue = portfolioCoins.map { coin -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = (coin.priceChangePercentage24h ?? 0) / 100
            let previousValue = (currentValue / (1 + percentChange))
            return previousValue
        }
        .reduce(0, +)

        let porfolioPercentageChange = ((portfolioValue / previousPortfolioValue) - 1) * 100

        let portfolio = StatisticModel(
            title: "Porfolio",
            value: portfolioValue.asCurrencyWithDecimals(),
            precentageChange: porfolioPercentageChange
        )

        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio,
        ])

        return stats
    }
}
