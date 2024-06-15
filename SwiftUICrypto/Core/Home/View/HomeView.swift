//
//  HomeView.swift
//  SwiftUICrypto
//
//  Created by saul on 6/6/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var homeVM: HomeViewModel
    @State private var showPortfolio: Bool = false

    var body: some View {
        ZStack {
            // Background Layer
            Color.theme.background
                .ignoresSafeArea()

            // Content Layer
            VStack {
                homeHeader

                SearchBarView(searchText: $homeVM.searchText)

                rowTitles

                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }

                Spacer()
            }
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
    }
    .environmentObject(HomeViewModel())
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .background(CircleButtonAnimationView(animate: $showPortfolio))
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)

            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }

    private var portfolioCoinsList: some View {
        List(homeVM.portfolioCoins) { coin in
            CoinRowView(
                coin: coin,
                showHoldingsColum: true
            )
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
        }
        .listStyle(.plain)
    }

    private var allCoinsList: some View {
        List(homeVM.allCoins) { coin in
            CoinRowView(
                coin: coin,
                showHoldingsColum: false
            )
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
        }
        .listStyle(.plain)
    }

    private var rowTitles: some View {
        HStack {
            Text("Coins")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(minWidth: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
        .padding(.top, 10)
    }
}
