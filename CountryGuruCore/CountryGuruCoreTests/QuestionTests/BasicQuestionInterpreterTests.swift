//
//  BasicQuestionInterpreterTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 14/3/25.
//

import Testing
@testable import CountryGuruCore

enum InquiryInterpreterError: Error {
    case notSupported
}

typealias InquiryCreator = (String) -> Inquiry

struct BasicQuestionInterpreter {
    let supportedInquiries: [String: InquiryCreator]
}

extension BasicQuestionInterpreter: InquiryInterpreter {
    func inquiry(from question: String) throws -> any Inquiry {
        guard let anInquiryCreator = supportedInquiries[question] else {
            throw InquiryInterpreterError.notSupported
        }
        return anInquiryCreator(question)
    }
}

struct BasicQuestionInterpreterTests {

    @Test func throws_on_no_matching_inquiry() throws {
        let inquiryMap = [
            CountryCapitalQuestion.question:
                { countryQuestion in
                    CountryCapitalQuestion(countryName: countryQuestion) as Inquiry
                }
        ]
        let sut = makeSUT(with: inquiryMap)
        
        #expect(throws: InquiryInterpreterError.notSupported, performing: {
            try sut.inquiry(from: "invalid question")
        })
    }
    
    @Test func maps_country_capital_question_successfully() throws {
        let inquiryMap = [
            CountryCapitalQuestion.question:
                { countryQuestion in
                    CountryCapitalQuestion(countryName: countryQuestion) as Inquiry
                }
        ]
        
        let sut = makeSUT(with: inquiryMap)
        
        #expect(
            try sut.inquiry(from: "What is the capital of")
            is CountryCapitalQuestion
        )
    }

}

extension BasicQuestionInterpreterTests {
    func makeSUT(with inquiriesMap: [String: InquiryCreator]) -> BasicQuestionInterpreter {
        BasicQuestionInterpreter(supportedInquiries: inquiriesMap)
    }
}
