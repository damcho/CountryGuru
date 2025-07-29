//
//  CoreMLInterpreterTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 29/7/25.
//

import CoreML
@testable import CountryGuruCore
import Testing

struct CoreMLInterpreterTests {
    @Test
    func throws_on_no_matching_inquiry() throws {
        let sut = makeSUT(with: [])

        #expect(throws: InquiryInterpreterError.notSupported) {
            try sut.inquiry(from: "invalid question")
        }

        #expect(throws: InquiryInterpreterError.notSupported) {
            try sut.inquiry(from: "What is the capital of")
        }
    }

    @Test
    func maps_country_capital_question_successfully() throws {
        let sut = makeSUT(with: [])

        #expect(
            try sut.inquiry(from: "What is the capital of Argentina?") is CountryCapitalQuestion
        )
        #expect(
            try sut.inquiry(from: "what's the capital of Argentina?") is CountryCapitalQuestion
        )
        #expect(
            try sut.inquiry(from: "capital of Argentina?") is CountryCapitalQuestion
        )
        #expect(
            try sut.inquiry(from: "capital of Argentina") is CountryCapitalQuestion
        )
        #expect(
            try sut.inquiry(from: "what capital of Brazil") is CountryCapitalQuestion
        )
    }

    @Test
    func maps_country_flag_question_successfully() throws {
        let sut = makeSUT(with: [])

        #expect(
            try sut.inquiry(from: "What is the flag of Brazil?") is CountryFlagQuestion
        )
        #expect(
            try sut.inquiry(from: "what's the flag of Brazil?") is CountryFlagQuestion
        )
        #expect(
            try sut.inquiry(from: "flag of Brazil?") is CountryFlagQuestion
        )
        #expect(
            try sut.inquiry(from: "flag of Brazil") is CountryFlagQuestion
        )
        #expect(
            try sut.inquiry(from: "what flag of Brazil") is CountryFlagQuestion
        )
    }

    @Test
    func maps_country_prenom_question_successfully() throws {
        let sut = makeSUT(with: [])

        #expect(
            try sut.inquiry(from: "What countries start with BR") is CountryPrenomQuestion
        )
        #expect(
            try sut.inquiry(from: "countries start with a") is CountryPrenomQuestion
        )
        #expect(
            try sut.inquiry(from: "country start with a") is CountryPrenomQuestion
        )
    }

    @Test
    func maps_country_iso_alpha_2_code_question_successfully() throws {
        let sut = makeSUT(with: [])

        #expect(
            try sut.inquiry(from: "What is the iso code of argentina?") is ISOalpha2CountryQuestion
        )
        #expect(
            try sut.inquiry(from: "iso alpha code of Brazil") is ISOalpha2CountryQuestion
        )
        #expect(
            try sut.inquiry(from: "what is alpha 2 code of Argentina") is ISOalpha2CountryQuestion
        )
    }
}

extension CoreMLInterpreterTests {
    func makeSUT(with inquiriesMap: [AnyInquiry]) -> CoreMLInterpreter {
        try! CoreMLInterpreter(model: CountryGuru(configuration: MLModelConfiguration()))
    }
}
