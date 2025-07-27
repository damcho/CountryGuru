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
    func cancells_inquiry_response_callback_on_second_inquiry() async throws {
        var firstInquiryResponseCallbackCalled = false
        var secondInquiryResponseCallbackCalled = false

        let sut = await makeSUT()

        await confirmation("wait for response callback to be called", expectedCount: 1) { Confirmation in
            await sut.ask(question: "first inquiry") {
                firstInquiryResponseCallbackCalled = true
                Confirmation()
            }
            let task1 = await sut.inquityTask
            await sut.ask(question: "second inquiry") {
                secondInquiryResponseCallbackCalled = true
                Confirmation()
            }
            let task2 = await sut.inquityTask
            await sut.inquityTask?.value

            #expect(task1?.isCancelled == true)
            #expect(task2?.isCancelled == false)
        }

        #expect(firstInquiryResponseCallbackCalled == false)
        #expect(secondInquiryResponseCallbackCalled == true)
    }
}

extension InquiryChatScreenViewModelTests {
    @MainActor
    func makeSUT() -> InquiryChatScreenViewModel {
        InquiryChatScreenViewModel {
            InquiryResponseViewModel { _ in
                .text("a response")
            }
        }
    }
}
