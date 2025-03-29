//
//  ChatMessageViewFactoryTests.swift
//  CountryGuruTests
//
//  Created by Damian Modernell on 25/3/25.
//

@testable import CountryGuru
import CountryGuruCore
import Testing

struct ChatMessageViewFactoryTests {
    @Test
    func creates_proper_message_view_on_corresponding_query_response() async throws {
        #expect(QueryResponse.text("a message").toView() is TextMessageView)
        #expect(QueryResponse.image(anyURL).toView() is ImageMessageView)
        #expect(QueryResponse.multiple(["a message"]).toView() is TextMessageView)
    }
}

var anyURL: URL {
    URL(string: "www.someurl.com")!
}
