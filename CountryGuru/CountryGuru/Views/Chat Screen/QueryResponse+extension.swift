//
//  QueryResponse+extension.swift
//  CountryGuru
//
//  Created by Damian Modernell on 25/3/25.
//

import CountryGuruCore
import Foundation
import SwiftUI

extension QueryResponse {
    func toView() -> any View {
        switch self {
        case let .text(message):
            TextMessageView(message: message)
        case let .image(aImageUrl):
            ImageMessageView(imageURL: aImageUrl)
        case let .multiple(messages):
            TextMessageView(
                message: messages.joined(separator: "\n")
            )
        default: EmptyView()
        }
    }
}
