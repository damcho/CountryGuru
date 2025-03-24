//
//  CountryFlagQuestion.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 17/3/25.
//

import Foundation

struct DecodableCountryFlag: Decodable {
    let flag: String
}

class CountryFlagQuestion: Inquiry {
    static let question = "What is the flag of"
    let countryName: String
    
    init(countryName: String) {
        self.countryName = countryName
    }
    
    func mappedResponse(from data: Data) throws -> QueryResponse {
        let decodedCountryFlags = try JSONDecoder().decode(
            [DecodableCountryFlag].self,
            from: data
        )
        guard let decodedFlag = decodedCountryFlags.first?.flag else {
            throw QueryResponseError.decoding
        }
        
        return .text(decodedFlag)
    }
    
    func makeURL(from baseURL: URL) -> URL {
        baseURL
            .appendingPathComponent("name/\(countryName)")
            .appending(queryItems: [URLQueryItem(name: "fields", value: "flag")])
    }
}
