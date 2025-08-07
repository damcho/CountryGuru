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
            .foregroundColor(.primary)
            .padding(12)
            .background(Color(.systemGray5))
            .addChatBubble(sender: true, error: false)
            .senderMessageAlignment()
    }
}
