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

        await confirmation(expectedCount: 1) { confirmation in
            let sut = await InquiryResponseViewModel(with: DummyQuestionHandable(action: { _ in
                confirmation()
                return .text("a response")
            }))

            await sut.ask(question)
        }
    }

    @Test
    func displays_retry_view_on_network_error() async throws {
        let question = "a question"

        let sut = await InquiryResponseViewModel(with: DummyQuestionHandable(action: { _ in
            throw HTTPClientError.timeout
        }))

        await sut.ask(question)
        #expect(await sut.state.toView() is RetryView)
    }

    @Test
    func displays_not_supported_message_on_not_supported_question() async throws {
        let question = "a question"

        let sut = await InquiryResponseViewModel(with: DummyQuestionHandable(action: { _ in
            throw InquiryInterpreterError.notSupported
        }))

        await sut.ask(question)

        await #expect(sut.state.toView() is Text)
    }

    @Test
    func displays_progress_view_on_init() async throws {
        let sut = await InquiryResponseViewModel(with: DummyQuestionHandable(action: { _ in
            throw InquiryInterpreterError.notSupported
        }))

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

actor DummyQuestionHandable: QuestionHandable {
    let action: (String) async throws -> QueryResponse
    init(action: @escaping (String) async throws -> QueryResponse) {
        self.action = action
    }

    func didAskRaw(_ question: String) async throws -> CountryGuruCore.QueryResponse {
        try await action(question)
    }
}
