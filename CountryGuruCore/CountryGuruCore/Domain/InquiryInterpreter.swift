//
//  InquiryInterpreter.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 14/3/25.
//

public enum InquiryInterpreterError: Error {
    case notSupported
}

public typealias InquiryCreator = @Sendable (String) -> Inquiry

public struct AnyInquiry: Sendable {
    let questionType: InquiryType
    let inquiryCreator: InquiryCreator

    public init(questionType: InquiryType, inquiryCreator: @escaping InquiryCreator) {
        self.questionType = questionType
        self.inquiryCreator = inquiryCreator
    }
}

public enum InquiryType: String, CaseIterable, Sendable {
    case countryCapital
    case countryISOalpha2code
    case countryFlag
    case countryPrenom
}

protocol InquiryInterpreter {
    func inquiry(from question: String) async throws -> any Inquiry
}
