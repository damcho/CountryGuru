//
//  ChatBubbleModifier.swift
//  CountryGuru
//
//  Created by Damian Modernell on 25/3/25.
//

import SwiftUI

struct ChatBubbleModifier: ViewModifier {
    let isSender: Bool
    func body(content: Content) -> some View {
        content
            .padding()
            .background(isSender ? .gray : .blue)
            .cornerRadius(50)
    }
}

extension View {
    func addChatBubble(sender: Bool) -> some View {
        modifier(ChatBubbleModifier(isSender: sender))
    }
}
