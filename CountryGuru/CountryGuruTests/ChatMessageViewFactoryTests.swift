//
//  ChatMessageViewFactoryTests.swift
//  CountryGuruTests
//
//  Created by Damian Modernell on 25/3/25.
//

@testable import CountryGuru
import CountryGuruCore
import SwiftUI
import Testing

struct ChatMessageViewFactoryTests {
    @Test
    func creates_proper_view_on_corresponding_query_response() async throws {
        await #expect(ResponseState.success(.text("a message")).toView() is Text)
        await #expect(ResponseState.success(.image(anyURL)).toView() is ImageMessageView)
        await #expect(ResponseState.success(.multiple(["a message"])).toView() is Text)
    }
}

var anyURL: URL {
    URL(string: "www.someurl.com")!
}
