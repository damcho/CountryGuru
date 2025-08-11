//
//  CoreMLInterpreter.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 28/7/25.
//

import CoreML
import Foundation
import NaturalLanguage

struct CoreMLInterpreter {
    let model: CountryGuru
    let inquiries: [AnyInquiry]

    func retrieveInquiry(for key: String) throws -> InquiryCreator {
        guard
            let anInquiry = inquiries.first(where: { inquiry in
                inquiry.question == key
            })
        else {
            throw InquiryInterpreterError.notSupported
        }
        return anInquiry.inquiryCreator
    }
}

// MARK: InquiryInterpreter

extension CoreMLInterpreter: InquiryInterpreter {
    func inquiry(from question: String) throws -> any Inquiry {
        do {
            let trimmedQUestion = question.lowercased().trimmingCharacters(in: CharacterSet(charactersIn: " .,:;!?"))
                .lowercased()
            let predictedIntent = try model
                .prediction(
                    text: trimmedQUestion
                )
            switch predictedIntent.label {
            case "capital":
                return try retrieveInquiry(
                    for: CountryCapitalQuestion.question
                )(
                    trimmedQUestion.extractDomain(
                        after: "of"
                    )
                )
            case "flag":
                return try retrieveInquiry(
                    for: CountryFlagQuestion.question
                )(
                    trimmedQUestion.extractDomain(
                        after: "of"
                    )
                )
            case "iso2":
                return try retrieveInquiry(
                    for: ISOalpha2CountryQuestion.question
                )(
                    trimmedQUestion.extractDomain(
                        after: "of"
                    )
                )
            case "startswith":
                return try retrieveInquiry(
                    for: CountryPrenomQuestion.question
                )(
                    trimmedQUestion.extractDomain(
                        after: "with"
                    )
                )
            default:
                throw InquiryInterpreterError.notSupported
            }
        } catch {
            throw InquiryInterpreterError.notSupported
        }
    }
}
