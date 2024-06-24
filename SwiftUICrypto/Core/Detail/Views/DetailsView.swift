//
//  DetailsView.swift
//  SwiftUICrypto
//
//  Created by saul on 6/23/24.
//

import SwiftUI

struct DetailsView: View {
    @ObservedObject private var detailVM: CoinDetailViewModel

    init(coin: CoinModel) {
        _detailVM = ObservedObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }

    var body: some View {
        Text(detailVM.coin.id)
        if let coinId = detailVM.coinDetail?.description?.en {
            Text(coinId)
        }
    }
}

#Preview {
    DetailsView(coin: DeveleperPreview.instance.coin)
}
