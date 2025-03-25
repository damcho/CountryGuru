//
//  ChatMessageViewFactoryTests.swift
//  CountryGuruTests
//
//  Created by Damian Modernell on 25/3/25.
//

import Testing
@testable import CountryGuru
import CountryGuruCore
import SwiftUI

extension QueryResponse {
    func toView() -> any View {
        switch self {
        case .text(let message):
            return TextMessageView(message: message)
        case.image(let aImageUrl):
            return ImageMessageView(imageURL: aImageUrl)
        case .multiple(let messages):
            return TextMessageView(message: messages.reduce(into: "", { $0 += "\n\($1)" } ))
        default: return EmptyView()
        }
    }
}

struct ChatMessageViewFactoryTests {

    @Test func creates_proper_message_view_on_corresponding_query_response() async throws {
        #expect(QueryResponse.text("a message").toView() is TextMessageView)
        #expect(QueryResponse.image(anyURL).toView() is ImageMessageView)
        #expect(QueryResponse.multiple(["a message"]).toView() is TextMessageView)
    }

}

var anyURL: URL {
    URL(string: "www.someurl.com")!
}
