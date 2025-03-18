//
//  CountryGuruTests.swift
//  CountryGuruTests
//
//  Created by Damian Modernell on 17/3/25.
//

import Testing
@testable import CountryGuru

struct InquiryChatScreenViewModelTests {

    @Test func adds_inquiry_on_question_asked() async throws {
        let sut = InquiryChatScreenViewModel()
        #expect(sut.inquiries.count == 0)

        sut.ask(question: "What is the capital of France?")
        
        #expect(sut.inquiries.count == 1)
    }

}
