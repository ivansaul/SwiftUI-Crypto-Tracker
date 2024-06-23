//
//  HapticManager.swift
//  SwiftUICrypto
//
//  Created by saul on 6/23/24.
//

import Foundation
import SwiftUI

class HapticManager {
    private init() {}

    private static let generator = UINotificationFeedbackGenerator()

    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        self.generator.notificationOccurred(type)
    }
}
