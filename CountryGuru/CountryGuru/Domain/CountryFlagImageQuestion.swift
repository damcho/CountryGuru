//
//  CountryFlagImageQuestion.swift
//  CountryGuru
//
//  Created by Damian Modernell on 26/3/25.
//

import Foundation
import CountryGuruCore

struct DecodableCountryFlagImage: Decodable {
    let png: String
}
struct DecodableCountryFlagImageRoot: Decodable {
    let flags: DecodableCountryFlagImage
}


class CountryFlagImageQuestion: CountryFlagQuestion {
    override func makeURL(from baseURL: URL) -> URL {
        baseURL
            .appendingPathComponent("name/\(countryName)")
            .appending(queryItems: [URLQueryItem(name: "fields", value: "flags")])
    }
    
    override func mappedResponse(from data: Data, httpURLResponse httpResponse: HTTPURLResponse) throws -> QueryResponse {
        guard httpResponse.statusCode == 200 else {
            throw HTTPClientError.notFound
        }
        let decodedCountryFlagImage = try JSONDecoder().decode(
            [DecodableCountryFlagImageRoot].self,
            from: data
        )
        guard let decodedFlag = decodedCountryFlagImage.first?.flags.png,
              let decodedFlagUrl = URL(string: decodedFlag) else {
            throw QueryResponseError.decoding
        }
        
        return .image(decodedFlagUrl)
    }
}
