//
//  IdentifiableChatRow.swift
//  CountryGuru
//
//  Created by Damian Modernell on 26/3/25.
//

import Foundation
import SwiftUI

@MainActor
protocol ViewableChatMessage: Sendable {
    associatedtype ChatMessageView: View
    func toChatMessageView() -> ChatMessageView
}

struct IdentifiableChatRow: Identifiable, Sendable {
    var id = UUID()
    let message: any ViewableChatMessage
}
