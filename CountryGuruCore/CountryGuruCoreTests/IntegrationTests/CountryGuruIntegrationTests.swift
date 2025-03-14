//
//  CountryGuruIntegrationTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 14/3/25.
//

import Testing
@testable import CountryGuruCore

enum CountryGuruComposer {
    static func compose(
        with httpClient: HTTPClient,
        supportedQuestions: [String: InquiryCreator]
    ) -> QuestionInterpreterAdapter {
        let adapter = QuestionInterpreterAdapter(
            inquiryLoader: RemoteInquiryLoader(
                httpClient: httpClient,
                baseURL: anyURL
            ),
            inquiryInterpreter: BasicQuestionInterpreter(
                supportedInquiries: supportedQuestions
            )
        )
        return adapter
    }
}

struct CountryGuruIntegrationTests {

    @Test func replies_country_question_successfully() async throws {
        let sut = makeSUT(
            httpStub: .success((anyHTTPURLResponse(), #"[{"capital": ["Buenos Aires"]}]"#.data(using: .utf8)!))
        )
        
        let result = try await sut.didAskRaw(CountryCapitalQuestion.question)
        
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
