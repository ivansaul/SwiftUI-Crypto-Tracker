//
//  DetailsView.swift
//  SwiftUICrypto
//
//  Created by saul on 6/23/24.
//

import SwiftUI

struct DetailsView: View {
    @ObservedObject private var detailVM: CoinDetailViewModel

    private let gridColumns = [GridItem(.flexible()), GridItem(.flexible())]
    private let gridSpacing: CGFloat = 30

    init(coin: CoinModel) {
        _detailVM = ObservedObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }

    var body: some View {
        ScrollView {
            VStack {
                // TODO: Implement ChartView
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray.opacity(0.3))
                    .frame(height: 250)
                overViewSection
                aditionalDetailsSection
            }
            .padding(.horizontal)
        }
        .navigationTitle(detailVM.coin.name)
    }
}

#Preview {
    NavigationView {
        DetailsView(coin: DeveleperPreview.instance.coin)
    }
}

extension DetailsView {
    private var overViewSection: some View {
        VStack {
            Text("Overview".uppercased())
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)

            Divider()

            LazyVGrid(columns: gridColumns, alignment: .leading, spacing: gridSpacing, content: {
                ForEach(detailVM.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })
        }
    }

    private var aditionalDetailsSection: some View {
        VStack {
            Text("Aditional Details".uppercased())
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)

            Divider()

            LazyVGrid(columns: gridColumns, alignment: .leading, spacing: gridSpacing, content: {
                ForEach(detailVM.aditionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })
        }
    }
}
