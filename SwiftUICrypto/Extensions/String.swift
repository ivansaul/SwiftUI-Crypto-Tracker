//
//  String.swift
//  SwiftUICrypto
//
//  Created by saul on 6/24/24.
//

import Foundation

extension String {
    func removeHTMLOccurances() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
