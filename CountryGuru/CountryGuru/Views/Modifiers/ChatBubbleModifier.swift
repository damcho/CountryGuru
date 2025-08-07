//
//  ChatBubbleModifier.swift
//  CountryGuru
//
//  Created by Damian Modernell on 25/3/25.
//

import SwiftUI

struct ChatBubbleModifier: ViewModifier {
    let isSender: Bool
    let isError: Bool

    func body(content: Content) -> some View {
        content
            .background(
                isError ? Color(red: 1.0, green: 0.95, blue: 0.95) :
                    isSender ? Color(.systemGray6) : .blue
            )
            .cornerRadius(16)
    }
}

extension View {
    func addChatBubble(sender: Bool, error: Bool) -> some View {
        modifier(ChatBubbleModifier(isSender: sender, isError: error))
    }
}
