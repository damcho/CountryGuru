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

open class CountryFlagQuestion: Inquiry {
    public static let question = "what is the flag of"
    public let countryName: String

    public init(countryName: String) {
        self.countryName = countryName
    }

    open func mappedResponse(from data: Data, httpURLResponse: HTTPURLResponse) throws -> QueryResponse {
        guard httpURLResponse.statusCode == 200 else {
            throw HTTPClientError.notFound
        }
        let decodedCountryFlags = try JSONDecoder().decode(
            [DecodableCountryFlag].self,
            from: data
        )
        guard let decodedFlag = decodedCountryFlags.first?.flag else {
            throw QueryResponseError.decoding
        }

        return .text(decodedFlag)
    }

    open func makeURL(from baseURL: URL) -> URL {
        baseURL
            .appendingPathComponent("name/\(countryName)")
            .appending(queryItems: [URLQueryItem(name: "fields", value: "flag")])
    }
}
