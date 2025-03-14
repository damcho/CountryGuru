//
//  CountryCapitalQuestion.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 13/3/25.
//

import Foundation

protocol Inquiry {
    func mappedResponse(from data: Data) throws -> QueryResponse
    func makeURL(from baseURL: URL) -> URL
}

struct CountryCapitalQuestion: Inquiry {
    let countryName: String
}
