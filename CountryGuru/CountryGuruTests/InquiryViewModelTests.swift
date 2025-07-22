//
//  InquiryViewModelTests.swift
//  CountryGuruTests
//
//  Created by Damian Modernell on 24/3/25.
//

@testable import CountryGuru
import CountryGuruCore
import SwiftUI
import Testing

struct InquiryViewModelTests {
    @Test
    func calls_question_handler_on_question_asked() async throws {
        let question = "a question"
        var questionHandlerCallCount = 0
        let sut = await InquiryViewModel(questionHandler: { _ in
            questionHandlerCallCount += 1
            return .text("a response")
        })

        await sut.ask(question)

        #expect(questionHandlerCallCount == 1)
    }

    @Test
    func displays_retry_view_on_network_error() async throws {
        let question = "a question"
        let sut = await InquiryViewModel(questionHandler: { _ in
            throw HTTPClientError.timeout
        })

        await sut.ask(question)
        #expect(await sut.state.toView() is RetryView)
    }

    @Test
    func displays_not_supported_message_on_not_supported_question() async throws {
        let question = "a question"
        let sut = await InquiryViewModel(questionHandler: { _ in
            throw InquiryInterpreterError.notSupported
        })

        await sut.ask(question)

        await #expect((sut.state.toView() as? TextMessageView)?.message == "This question is not supported")
    }

    @Test
    func displays_progress_view_on_init() async throws {
        let sut = await InquiryViewModel(questionHandler: { _ in
            throw InquiryInterpreterError.notSupported
        })

        await #expect(sut.state.toView() is ProgressView<EmptyView, EmptyView>)
    }
}

actor ResponseActor {
    var receivedResponses: [String] = []

    func didRespond(_ response: String) {
        print(response)
        receivedResponses.append(response)
    }
}
