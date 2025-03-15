//
//  BasicQuestionInterpreter.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 14/3/25.
//

enum InquiryInterpreterError: Error {
    case notSupported
}

public typealias InquiryCreator = (String) -> Inquiry

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
