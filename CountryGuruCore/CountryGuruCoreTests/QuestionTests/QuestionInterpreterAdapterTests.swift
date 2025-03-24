//
//  QuestionInterpreterTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 14/3/25.
//

import Testing
@testable import CountryGuruCore

struct QuestionInterpreterAdapterTests {

    @Test func throws_on_bad_question_interpretation() async throws {
        let sut = makeSUT(interpreterStub: .failure(anyError))
        let aQuestion = "this is a question?"
        await #expect(throws: anyError) {
            try await sut.didAskRaw(aQuestion)
        }
    }
    
    @Test func creates_country_capital_question_successfully() async throws {
        let aQueryResponse = QueryResponse.text("Buenos Aires")
        let sut = makeSUT(
            loaderStub: .success(aQueryResponse),
            interpreterStub: .success(anyQuestion)
        )
        
        let aValidQuestion = "What is the capital of Argentina?"

        async #expect(try sut.didAskRaw(aValidQuestion) == aQueryResponse)
    }
}

extension QuestionInterpreterAdapterTests {
    func makeSUT(
        loaderStub: Result<QueryResponse, Error> = .failure(anyError),
        interpreterStub: Result<Inquiry, Error>
    ) -> QuestionInterpreterAdapter {
        QuestionInterpreterAdapter(
            inquiryLoader: InquiryLoaderStub(stub: loaderStub),
            inquiryInterpreter: QuestionInterpreterStub(stub: interpreterStub)
        )
    }
}

struct QuestionInterpreterStub: InquiryInterpreter {
    let stub: Result<Inquiry, Error>
    func inquiry(from question: String) throws -> any Inquiry {
        try stub.get()
    }
}
