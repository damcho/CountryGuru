//
//  InquiryChatScreenViewModelTests.swift
//  CountryGuruTests
//
//  Created by Damian Modernell on 17/3/25.
//

@testable import CountryGuru
import CountryGuruCore
import Testing

struct InquiryChatScreenViewModelTests {
    @Test
    func adds_inquiry_on_question_asked() async throws {
        let sut = await makeSUT()
        #expect(await sut.rows.count == 0)

        _ = await sut.ask(question: "What is the capital of France?")

        #expect(await sut.rows.count == 2)
    }

    @Test
    func cancells_first_inquiry_response_callback_on_second_inquiry() async throws {
        let sut = await makeSUT(asyncTask: taskWithDelay)

        await sut.ask(question: "first inquiry")
        let firstTask = await sut.inquityTask

        await sut.ask(question: "second inquiry")
        let secondTask = await sut.inquityTask
        #expect(firstTask?.isCancelled == true)

        await secondTask?.value

        #expect(secondTask?.isCancelled == false)
    }
}

extension InquiryChatScreenViewModelTests {
    var taskWithDelay: @Sendable (String) async throws -> QueryResponse {
        { _ in
            try await Task.sleep(nanoseconds: 100)
            return .text("a response")
        }
    }

    @MainActor
    func makeSUT(asyncTask: @escaping @Sendable (String) async throws -> QueryResponse = { _ in
        .text("text response")
    }) -> InquiryChatScreenViewModel {
        InquiryChatScreenViewModel {
            InquiryResponseViewModel(with: DummyQuestionHandable(action: asyncTask))
        }
    }
}
