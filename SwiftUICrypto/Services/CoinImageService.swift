//
//  CoinImageService.swift
//  SwiftUICrypto
//
//  Created by saul on 6/14/24.
//

import Combine
import Foundation
import SwiftUI

class CoinImageService {
    @Published var image: UIImage? = nil
    private var subscription: AnyCancellable?
    private var coin: CoinModel

    init(coin: CoinModel) {
        self.coin = coin
        fetchCoinImage(coin: coin)
    }

    private func fetchCoinImage(coin: CoinModel) {
        guard let url = URL(string: coin.image) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        subscription = NetworkingManager.download(urlRequest: request)
            .tryMap { data -> UIImage? in
                UIImage(data: data)
            }
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] returnedImage in
                    self?.image = returnedImage
                    self?.subscription?.cancel()
                }
            )
    }
}
