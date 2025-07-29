//
//  Inquiry.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 17/3/25.
//
import NaturalLanguage

public protocol Inquiry {
    func mappedResponse(from data: Data, httpURLResponse: HTTPURLResponse) throws -> QueryResponse
    func makeURL(from baseURL: URL) -> URL
}

extension String {
    func extractDomain(after delimeter: String) throws -> String {
        let pattern = delimeter + #"\s+(.+)"#

        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            let range = NSRange(startIndex..., in: self)
            if
                let match = regex.firstMatch(in: self, options: [], range: range),
                let resultRange = Range(match.range(at: 1), in: self)
            {
                return String(self[resultRange]).trimmingCharacters(in: .punctuationCharacters)
            }
        }
        throw InquiryInterpreterError.notSupported
    }
}
