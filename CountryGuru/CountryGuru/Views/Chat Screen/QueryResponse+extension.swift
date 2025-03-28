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
        case.image(let aImageUrl):
            return ImageMessageView(imageURL: aImageUrl)
        case .multiple(let messages):
            return TextMessageView(
                message: messages.joined(separator: "\n")
            )
        default: return EmptyView()
        }
    }
}
