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
}

// MARK: InquiryInterpreter

extension CoreMLInterpreter: InquiryInterpreter {
    func inquiry(from question: String) throws -> any Inquiry {
        do {
            let predictedIntent = try model.prediction(text: question.lowercased())
            switch predictedIntent.label {
            case "capital":
                return try CountryCapitalQuestion(
                    countryName: question.extractDomain(after: "of")
                )
            case "flag":
                return try CountryFlagQuestion(
                    countryName: question.extractDomain(after: "of")
                )
            case "iso2":
                return try ISOalpha2CountryQuestion(
                    countryName: question.extractDomain(after: "of")
                )
            case "startswith":
                return try CountryPrenomQuestion(
                    countryPrenom: question.extractDomain(after: "with")
                )
            default:
                throw InquiryInterpreterError.notSupported
            }
        } catch {
            throw InquiryInterpreterError.notSupported
        }
    }
}
