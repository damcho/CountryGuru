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
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        isError ? Color(.systemRed).opacity(0.1) :
                            isSender ? Color(.systemGray5) : Color.blue
                    )
            )
            .cornerRadius(20)
            .shadow(
                color: isError ? .red.opacity(0.2) : .black.opacity(0.1),
                radius: isError ? 2 : 1,
                x: 0,
                y: 1
            )
    }
}

extension View {
    func addChatBubble(sender: Bool, error: Bool) -> some View {
        modifier(ChatBubbleModifier(isSender: sender, isError: error))
    }
}
