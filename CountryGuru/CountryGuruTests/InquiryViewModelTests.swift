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
    func displays_not_supported_message_on_not_found_response_error() async throws {
        let question = "a question"

        let sut = await InquiryResponseViewModel(with: DummyQuestionHandable(action: { _ in
            throw HTTPClientError.notFound
        }))

        await sut.ask(question)

        let aState = await sut.state
        #expect(ResponseState.notSupported == aState)
    }

    @Test
    func displays_not_supported_message_on_not_supported_response_error() async throws {
        let question = "a question"

        let sut = await InquiryResponseViewModel(with: DummyQuestionHandable(action: { _ in
            throw InquiryInterpreterError.notSupported
        }))

        await sut.ask(question)

        let aState = await sut.state
        #expect(ResponseState.notSupported == aState)
    }

    @Test
    func displays_progress_view_on_init() async throws {
        let sut = await InquiryResponseViewModel(with: DummyQuestionHandable(action: { _ in
            throw InquiryInterpreterError.notSupported
        }))

        await #expect(sut.state.toView() is ResponseLoaderIndicatorView)
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

// MARK: - Test-only Equatable for ResponseState

extension ResponseState: @retroactive Equatable {
    public static func == (lhs: ResponseState, rhs: ResponseState) -> Bool {
        switch (lhs, rhs) {
        case (.processing, .processing):
            true
        case (.notSupported, .notSupported):
            true
        case let (.success(a), .success(b)):
            areEqualQueryResponse(a, b)
        case let (.error(_, qa), .error(_, qb)):
            // Ignore closure identity; compare only the question string
            qa == qb
        default:
            false
        }
    }
}

private func areEqualQueryResponse(_ lhs: QueryResponse, _ rhs: QueryResponse) -> Bool {
    switch (lhs, rhs) {
    case let (.text(la), .text(ra)):
        la == ra
    case let (.image(lu), .image(ru)):
        lu == ru
    case let (.multiple(la), .multiple(ra)):
        la == ra
    default:
        false
    }
}
