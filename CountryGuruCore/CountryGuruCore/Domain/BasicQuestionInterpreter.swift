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
        var splittedQUestion = question.components(separatedBy: " ")
        guard let data = splittedQUestion.last else {
            throw InquiryInterpreterError.notSupported
        }
        
        splittedQUestion.removeLast()
        let questionbody = splittedQUestion.joined(separator: " ")
        guard let anInquiryCreator = supportedInquiries[questionbody] else {
            throw InquiryInterpreterError.notSupported
        }
        return anInquiryCreator(data)
    }
}
