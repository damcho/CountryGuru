//
//  InquiryViewModelTests.swift
//  CountryGuruTests
//
//  Created by Damian Modernell on 24/3/25.
//

@testable import CountryGuru
import CountryGuruCore
import Testing

struct InquiryViewModelTests {
    @Test
    func calls_question_handler_on_did_ask_question() async throws {
        let question = "a question"
        var questionHandlerCallCount = 0
        let sut = await InquiryViewModel(questionHandler: { _ in
            questionHandlerCallCount += 1
            return .text("a response")
        })

        let task = await sut.didAsk(question)
        await task.value

        #expect(questionHandlerCallCount == 1)
    }

    @Test
    func displays_retry_view_on_network_error() async throws {
        let question = "a question"
        let sut = await InquiryViewModel(questionHandler: { _ in
            throw HTTPClientError.timeout
        })

        let task = await sut.didAsk(question)
        await task.value
        #expect(await sut.receiverView is RetryView)
    }

    @Test
    func displays_not_supported_message_on_not_supported_question() async throws {
        let question = "a question"
        let sut = await InquiryViewModel(questionHandler: { _ in
            throw InquiryInterpreterError.notSupported
        })

        let task = await sut.didAsk(question)
        await task.value

        await #expect((sut.receiverView as? TextMessageView)?.message == "This question is not supported")
    }
}

actor ResponseActor {
    var receivedResponses: [String] = []

    func didRespond(_ response: String) {
        print(response)
        receivedResponses.append(response)
    }
}
