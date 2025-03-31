//
//  BasicQuestionInterpreter.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 14/3/25.
//

public enum InquiryInterpreterError: Error {
    case notSupported
}

public typealias InquiryCreator = (String) -> Inquiry

struct BasicQuestionInterpreter {
    let supportedInquiries: [String: InquiryCreator]

    func trim(_ question: String) -> String {
        question.trimmingCharacters(in: CharacterSet(charactersIn: " .,:;!?")).lowercased()
    }
}

// MARK: InquiryInterpreter

extension BasicQuestionInterpreter: InquiryInterpreter {
    func inquiry(from question: String) throws -> any Inquiry {
        let trimmedQuestion = trim(question)
        var splittedQUestion = trimmedQuestion.components(separatedBy: " ")
        guard let questionData = splittedQUestion.last else {
            throw InquiryInterpreterError.notSupported
        }

        splittedQUestion.removeLast()
        let questionbody = splittedQUestion.joined(separator: " ")
        guard let anInquiryCreator = supportedInquiries[questionbody] else {
            throw InquiryInterpreterError.notSupported
        }
        return anInquiryCreator(questionData)
    }
}
