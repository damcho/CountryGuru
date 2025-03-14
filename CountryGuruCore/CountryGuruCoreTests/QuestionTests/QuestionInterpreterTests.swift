//
//  QuestionInterpreterTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 14/3/25.
//

import Testing

struct QuestionInterpreter {
    func didAskRaw(_ question: String) throws {
        throw anyError
    }
}

struct QuestionInterpreterTests {

    @Test func throws_on_bad_question_interpretation() async throws {
        let sut = makeSUT()
        let aQuestion = "this is a question?"
        #expect(throws: anyError) {
            try sut.didAskRaw(aQuestion)
        }
    }

}

extension QuestionInterpreterTests {
    func makeSUT() -> QuestionInterpreter {
        QuestionInterpreter()
    }
}
