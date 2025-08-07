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
            let predictedIntent = try model.prediction(text: question.lowercased())
            switch predictedIntent.label {
            case "capital":
                return try retrieveInquiry(
                    for: CountryCapitalQuestion.question
                )(
                    question.extractDomain(
                        after: "of"
                    )
                )
            case "flag":
                return try retrieveInquiry(
                    for: CountryFlagQuestion.question
                )(
                    question.extractDomain(
                        after: "of"
                    )
                )
            case "iso2":
                return try retrieveInquiry(
                    for: ISOalpha2CountryQuestion.question
                )(
                    question.extractDomain(
                        after: "of"
                    )
                )
            case "startswith":
                return try retrieveInquiry(
                    for: CountryPrenomQuestion.question
                )(
                    question.extractDomain(
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
