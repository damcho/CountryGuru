//
//  CountryGuruIntegrationTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 14/3/25.
//

import Testing
@testable import CountryGuruCore

struct CountryGuruIntegrationTests {

    @Test func replies_country_question_successfully() async throws {
        let sut = makeSUT(
            httpStub: .success((anyHTTPURLResponse(), #"[{"capital": ["Buenos Aires"]}]"#.data(using: .utf8)!))
        )
        
        let result = try await sut.didAskRaw("What is the capital of Argentina")
        
        #expect(result == QueryResponse(responseString: "Buenos Aires"))
    }
}

extension CountryGuruIntegrationTests {
    func makeSUT(httpStub: Result<(HTTPURLResponse, Data), HTTPClientError>) -> QuestionInterpreterAdapter {
        CountryGuruComposer.compose(
            with: HTTPClientStub(result: httpStub),
            supportedQuestions: [
                CountryCapitalQuestion.question:
                    {question in CountryCapitalQuestion(countryName: question)}
            ]
        )
    }
}
