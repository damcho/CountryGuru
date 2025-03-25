//
//  QueryResponse+extension.swift
//  CountryGuru
//
//  Created by Damian Modernell on 25/3/25.
//

import Foundation
import SwiftUI
import CountryGuruCore

extension QueryResponse {
    func toView() -> any View {
        switch self {
        case .text(let message):
            return TextMessageView(message: message)
                .addChatBubble(sender: false)
                .receiverMessageAlignment()
        case.image(let aImageUrl):
            return ImageMessageView(imageURL: aImageUrl)
                .receiverMessageAlignment()
        case .multiple(let messages):
            return TextMessageView(
                message: messages.reduce(into: "", { $0 += "\n\($1)" } )
            )
            .addChatBubble(sender: false)
            .receiverMessageAlignment()
        default: return EmptyView()
        }
    }
}
