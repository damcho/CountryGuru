//
//  ChatBubbleModifier.swift
//  CountryGuru
//
//  Created by Damian Modernell on 25/3/25.
//

import SwiftUI

struct ChatBubbleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .padding()
        .background(Color.red)
        .cornerRadius(50)
    }
}

extension View {
    func addChatBubble() -> some View {
        modifier(ChatBubbleModifier())
    }
}
