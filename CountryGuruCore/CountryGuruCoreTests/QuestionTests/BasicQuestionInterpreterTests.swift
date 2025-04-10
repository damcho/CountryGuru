//
//  BasicQuestionInterpreterTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 14/3/25.
//

@testable import CountryGuruCore
import Testing

struct BasicQuestionInterpreterTests {
    @Test
    func throws_on_no_matching_inquiry() throws {
        let inquiryMap = [
            CountryCapitalQuestion.question: { countryQuestion in
                CountryCapitalQuestion(countryName: countryQuestion) as Inquiry
            }
        ]
        let sut = makeSUT(with: inquiryMap)

        #expect(throws: InquiryInterpreterError.notSupported, performing: {
            try sut.inquiry(from: "invalid question")
        })
    }

    @Test
    func maps_country_capital_question_successfully() throws {
        let countryName = "argentina"
        let inquiryMap = [
            CountryCapitalQuestion.question: { countryQuestion in
                CountryCapitalQuestion(countryName: countryQuestion) as Inquiry
            }
        ]

        let sut = makeSUT(with: inquiryMap)
        let question = try sut.inquiry(from: "What is the capital of \(countryName)")

        #expect(question is CountryCapitalQuestion)
        #expect((question as? CountryCapitalQuestion)?.countryName == countryName)
    }
}

extension BasicQuestionInterpreterTests {
    func makeSUT(with inquiriesMap: [String: InquiryCreator]) -> BasicQuestionInterpreter {
        BasicQuestionInterpreter(supportedInquiries: inquiriesMap)
    }
}
