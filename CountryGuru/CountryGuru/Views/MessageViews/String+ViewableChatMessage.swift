//
//  String+ViewableChatMessage.swift
//  CountryGuru
//
//  Created by Damian Modernell on 24/7/25.
//

import Foundation
import SwiftUI

extension String: ViewableChatMessage {
    func toChatMessageView() -> some View {
        Text(self)
            .font(.body)
            .foregroundColor(.primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .addChatBubble(sender: true, error: false)
            .senderMessageAlignment()
    }
}
