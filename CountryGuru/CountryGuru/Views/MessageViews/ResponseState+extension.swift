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
    func toView() -> any View {
        switch self {
        case .processing:
            ProgressView()
        case let .error(ask, question):
            RetryView(
                onRetry: {
                    Task {
                        await ask(question)
                    }
                }
            )
        case .notSupported:
            Text(
                "This question is not supported"
            )
        case let .success(response):
            switch response {
            case let .text(message):
                Text(message)
            case let .image(aImageUrl):
                ImageMessageView(imageURL: aImageUrl)
            case let .multiple(messages):
                Text(
                    messages.joined(separator: "\n")
                )
            default: EmptyView()
            }
        }
    }
}
