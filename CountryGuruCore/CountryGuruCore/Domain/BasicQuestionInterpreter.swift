//
//  BasicQuestionInterpreter.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 14/3/25.
//

public enum InquiryInterpreterError: Error {
    case notSupported
}

public typealias InquiryCreator = @Sendable (String) -> Inquiry

public struct AnyInquiry: Sendable {
    let question: String
    let inquiryCreator: InquiryCreator

    public init(question: String, inquiryCreator: @escaping InquiryCreator) {
        self.question = question
        self.inquiryCreator = inquiryCreator
    }
}

struct BasicQuestionInterpreter {
    let supportedInquiries: [AnyInquiry]

    func trim(_ question: String) -> String {
        question.trimmingCharacters(in: CharacterSet(charactersIn: " .,:;!?")).lowercased()
    }

    private func supportedInquiry(for question: String) throws -> AnyInquiry {
        guard
            let anInquiry = supportedInquiries.first(where: { inquiry in
                question.contains(inquiry.question.lowercased())
            })
        else {
            throw InquiryInterpreterError.notSupported
        }
        return anInquiry
    }
}

// MARK: InquiryInterpreter

extension BasicQuestionInterpreter: InquiryInterpreter {
    func inquiry(from question: String) throws -> any Inquiry {
        let trimmedQuestion = trim(question)
        let anInquiry = try supportedInquiry(for: trimmedQuestion)
        let questionData = trimmedQuestion.replacingOccurrences(
            of: anInquiry.question,
            with: ""
        ).trimmingCharacters(in: .whitespaces)

        return anInquiry.inquiryCreator(questionData)
    }
}
