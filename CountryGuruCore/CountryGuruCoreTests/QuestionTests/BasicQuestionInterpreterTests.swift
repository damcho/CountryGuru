//
//  BasicQuestionInterpreterTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 14/3/25.
//

import Testing
@testable import CountryGuruCore

struct BasicQuestionInterpreter {
}

extension BasicQuestionInterpreter: InquiryInterpreter {
    func inquiry(from question: String) throws -> any CountryGuruCore.Inquiry {
        throw anyError
    }
}

struct BasicQuestionInterpreterTests {

    @Test func throws_on_no_matching_inquiry() throws {
        let sut = makeSUT()
        
        #expect(throws: anyError, performing: {
            try sut.inquiry(from: "invalid question")
        })
    }

}

extension BasicQuestionInterpreterTests {
    func makeSUT() -> BasicQuestionInterpreter {
        BasicQuestionInterpreter()
    }
}
