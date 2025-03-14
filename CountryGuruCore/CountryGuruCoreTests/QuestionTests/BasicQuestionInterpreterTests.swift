//
//  BasicQuestionInterpreterTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 14/3/25.
//

import Testing
@testable import CountryGuruCore

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
