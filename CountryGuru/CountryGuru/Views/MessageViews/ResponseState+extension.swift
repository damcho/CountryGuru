//
//  ResponseState+extension.swift
//  CountryGuru
//
//  Created by Damian Modernell on 25/3/25.
//

import CountryGuruCore
import Foundation
import SwiftUI

extension ResponseState {
    @MainActor
    func toView() -> any View {
        switch self {
        case .processing:
            ResponseLoaderIndicatorView()
        case let .error(ask, question):
            RetryView(
                onRetry: {
                    Task {
                        await ask(question)
                    }
                }
            )
        case .notSupported:
            ReceiverTextMessageView(
                text: "I couldn't understand your question. Try asking about country capitals, flags, ISO codes, or countries that start with specific letters."
            )
        case let .success(response):
            switch response {
            case let .text(message):
                ReceiverTextMessageView(text: message)
            case let .image(aImageUrl):
                ImageMessageView(imageURL: aImageUrl)
            case let .multiple(messages):
                ReceiverTextMessageView(text: messages.joined(separator: "\n"))
            default: EmptyView()
            }
        }
    }
}
