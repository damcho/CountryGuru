//
//  ChatMessageViewFactoryTests.swift
//  CountryGuruTests
//
//  Created by Damian Modernell on 25/3/25.
//

@testable import CountryGuru
import CountryGuruCore
import SwiftUICore
import Testing

struct ChatMessageViewFactoryTests {
    @Test
    func creates_proper_view_on_corresponding_query_response() async throws {
        #expect(ResponseState.success(.text("a message")).toView() is Text)
        #expect(ResponseState.success(.image(anyURL)).toView() is ImageMessageView)
        #expect(ResponseState.success(.multiple(["a message"])).toView() is Text)
    }
}

var anyURL: URL {
    URL(string: "www.someurl.com")!
}
