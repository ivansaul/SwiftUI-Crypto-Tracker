//
//  CircleButtonView.swift
//  SwiftUICrypto
//
//  Created by saul on 6/6/24.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(Color.theme.background)
            .clipShape(Circle())
            .shadow(
                color: Color.theme.accent.opacity(0.4),
                radius: 5
            )
    }
}

#Preview {
    CircleButtonView(iconName: "paperplane.fill")
}
