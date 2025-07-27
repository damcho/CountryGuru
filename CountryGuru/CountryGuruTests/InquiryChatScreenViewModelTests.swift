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
        #expect(await sut.rows.count == 0)

        _ = await sut.ask(question: "What is the capital of France?", onInquiryResponse: {})

        #expect(await sut.rows.count == 2)
    }

    @Test
    func cancells_first_inquiry_response_callback_on_second_inquiry() async throws {
        var firstInquiryResponseCallbackCalled = false
        var secondInquiryResponseCallbackCalled = false

        let sut = await makeSUT(asyncTask: taskWithDelay)

        await confirmation("for response callback to be called", expectedCount: 1) { Confirmation in
            await sut.ask(question: "first inquiry") {
                firstInquiryResponseCallbackCalled = true
                Confirmation()
            }
            let firstTask = await sut.inquityTask
            await sut.ask(question: "second inquiry") {
                secondInquiryResponseCallbackCalled = true
                Confirmation()
            }
            let secondTask = await sut.inquityTask
            await sut.inquityTask?.value

            #expect(firstTask?.isCancelled == true)
            #expect(secondTask?.isCancelled == false)
        }

        #expect(firstInquiryResponseCallbackCalled == false)
        #expect(secondInquiryResponseCallbackCalled == true)
    }
}

extension InquiryChatScreenViewModelTests {
    var taskWithDelay: InquiryHandler {
        { _ in
            try await Task.sleep(nanoseconds: 100)
            return .text("a response")
        }
    }

    @MainActor
    func makeSUT(asyncTask: @escaping InquiryHandler = { _ in .text("text response") }) -> InquiryChatScreenViewModel {
        InquiryChatScreenViewModel {
            InquiryResponseViewModel(questionHandler: asyncTask)
        }
    }
}
