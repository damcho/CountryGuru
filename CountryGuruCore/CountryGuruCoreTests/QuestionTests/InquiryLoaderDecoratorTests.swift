//
//  InquiryLoaderDecoratorTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 13/3/25.
//

import Testing
@testable import CountryGuruCore

struct InquiryLoaderDecorator {
    
    func didAsk(_ question: Inquiry) async throws -> QueryResponse {
        throw anyError
    }
}

struct InquiryLoaderDecoratorTests {

    @Test func throws_on_query_error() async throws {
        let sut = InquiryLoaderDecorator()
        
        await #expect(throws: anyError, performing: {
            try await sut.didAsk(anyQuestion)
        })
    }

}

var anyQuestion: Inquiry {
    CountryCapitalQuestion(countryName: "Argentina")
}
