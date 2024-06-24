//
//  CoinDetailViewModel.swift
//  SwiftUICrypto
//
//  Created by saul on 6/23/24.
//

import Combine
import Foundation

class CoinDetailViewModel: ObservableObject {
    @Published var coinDetail: CoinDetailModel? = nil

    private let coinDetailDataService: CoinDetailDataService

    private var cancellables = Set<AnyCancellable>()

    let coin: CoinModel

    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }

    private func addSubscribers() {
        self.coinDetailDataService.$coinDetail
            .sink { [weak self] returnedCoinDetail in
                self?.coinDetail = returnedCoinDetail
            }
            .store(in: &self.cancellables)
    }
}
