//
//  InquiryChatScreenViewModelTests.swift
//  CountryGuruTests
//
//  Created by Damian Modernell on 17/3/25.
//

@testable import CountryGuru
import Testing

struct InquiryChatScreenViewModelTests {
    @Test
    func adds_inquiry_on_question_asked() async throws {
        let sut = await makeSUT()
        #expect(await sut.inquiries.count == 0)

        _ = await sut.ask(question: "What is the capital of France?", onQuestionResponse: {})

        #expect(await sut.inquiries.count == 2)
    }
}

extension InquiryChatScreenViewModelTests {
    @MainActor
    func makeSUT() -> InquiryChatScreenViewModel {
        InquiryChatScreenViewModel {
            InquiryViewModel { _ in
                .text("a response")
            }
        }
    }
}
