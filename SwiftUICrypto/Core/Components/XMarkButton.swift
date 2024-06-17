//
//  XMarkButton.swift
//  SwiftUICrypto
//
//  Created by saul on 6/9/24.
//

import SwiftUI

struct XMarkButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XMarkButton(action: {})
}
