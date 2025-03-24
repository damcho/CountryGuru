//
//  InquiryViewModelTests.swift
//  CountryGuruTests
//
//  Created by Damian Modernell on 24/3/25.
//

import Testing
@testable import CountryGuru
import CountryGuruCore

struct InquiryViewModelTests {

    @Test func calls_question_handler_on_did_ask_question() async throws {
        let question = "a question"
        var questionHandlerCallCount = 0
        let sut = InquiryViewModel(questionHandler: { _ in
            questionHandlerCallCount += 1
            return .text("a response")
        })
        
        let questionTask = sut.didAsk(question)
        try await questionTask.value
        #expect(questionHandlerCallCount == 1)
    }

}
