//
//  LazyView.swift
//  SwiftUICrypto
//
//  Created by saul on 6/23/24.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}

#Preview {
    LazyView(EmptyView())
}
