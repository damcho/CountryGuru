//
//  IdentifiableChatRow.swift
//  CountryGuru
//
//  Created by Damian Modernell on 26/3/25.
//

import Foundation
import SwiftUI

protocol ViewableChatMessage {
    associatedtype ChatMessageView: View
    func toChatMessageView() -> ChatMessageView
}

struct IdentifiableChatRow: Identifiable {
    var id = UUID()
    let message: any ViewableChatMessage
}
