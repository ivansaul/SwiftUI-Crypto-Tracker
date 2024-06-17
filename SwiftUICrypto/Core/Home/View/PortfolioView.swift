//
//  PortfolioView.swift
//  SwiftUICrypto
//
//  Created by saul on 6/9/24.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var homeVm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @Environment(\.dismiss) var dismiss
    @State var quantityText: String = ""

    var body: some View {
        let showSaveButton = selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)
        NavigationView {
            ScrollView {
                SearchBarView(searchText: $homeVm.searchText)
                coinsLogosList

                if selectedCoin != nil {
                    portfolioInputSection
                }
            }
            .background(
                Color.theme.background
                    .ignoresSafeArea()
            )
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton(action: { dismiss() })
                }

                ToolbarItem(placement: .topBarTrailing) {
                    saveButton
                        .opacity(showSaveButton ? 1 : 0)
                }

            })
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(HomeViewModel())
}

extension PortfolioView {
    private var coinsLogosList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(homeVm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(5)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(selectedCoin?.id == coin.id
                                    ? Color.theme.green
                                    : Color.clear,
                                    lineWidth: 2)
                        )
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                }
            }
            .padding(.vertical, 5)
            .padding(.leading)
        }
    }

    private var portfolioInputSection: some View {
        return VStack {
            HStack {
                Text("Current Price:")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWithDecimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex. 1.5", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWithDecimals())
            }
        }
        .animation(.none, value: UUID())
        .font(.headline)
        .padding()
    }

    private var saveButton: some View {
        Button(action: {
            onSaveButtonPressed()
        }, label: {
            Text("Save".uppercased())
                .font(.headline)
        })
    }

    private func getCurrentValue() -> Double {
        guard
            let quantity = Double(quantityText),
            let currentPrice = selectedCoin?.currentPrice
        else {
            return 0
        }
        return quantity * currentPrice
    }

    private func onSaveButtonPressed() {
        // Save to portfolio
        // TODO: implement

        // Remove selectedCoin
        selectedCoin = nil

        // Hide keyboard
        UIApplication.shared.endEditing()

        // Reset search text
        homeVm.searchText = ""
    }
}
