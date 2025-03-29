//
//  ISOalpha2CountryQuestion.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 28/3/25.
//

import Foundation

struct DecodableAlpha2Code: Decodable {
    let cca2: String
}

struct ISOalpha2CountryQuestion: Inquiry {
    public static let question = "what is the iso alpha-2 country code for"

    let countryName: String
    func mappedResponse(from data: Data, httpURLResponse: HTTPURLResponse) throws -> QueryResponse {
        guard httpURLResponse.statusCode == 200 else {
            throw HTTPClientError.notFound
        }
        let capitalCityArray = try JSONDecoder().decode(
            [DecodableAlpha2Code].self,
            from: data
        )
        guard let cca2 = capitalCityArray.first?.cca2 else {
            throw QueryResponseError.decoding
        }

        return .text(cca2)
    }

    var queryItems: [URLQueryItem] {
        [URLQueryItem(name: "fields", value: "cca2")]
    }

    var queryPath: String {
        "/name/\(countryName)"
    }

    func makeURL(from baseURL: URL) -> URL {
        baseURL
            .appendingPathComponent(queryPath)
            .appending(queryItems: queryItems)
    }
}
