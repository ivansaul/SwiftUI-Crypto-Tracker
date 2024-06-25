//
//  Color.swift
//  SwiftUICrypto
//
//  Created by saul on 6/6/24.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let lounch = LounchTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct LounchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
