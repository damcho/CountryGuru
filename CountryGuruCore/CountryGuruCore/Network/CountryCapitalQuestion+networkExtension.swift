//
//  CountryCapitalQuestion+networkExtension.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 13/3/25.
//

import Foundation

enum QueryResponseError: Error {
    case decoding
}

struct DecodableCountry: Decodable {
    let capital: [String]
}

extension CountryCapitalQuestion {
    var queryPath: String {
        return "/name/\(countryName)"
    }
    
    var queryItems: [URLQueryItem] {
        [URLQueryItem(name: "fields", value: "capital")]
    }
    
    public func makeURL(from baseURL: URL) -> URL {
        baseURL
            .appendingPathComponent(queryPath)
            .appending(queryItems: queryItems)
    }

    public func mappedResponse(from data: Data) throws -> QueryResponse {
        let capitalCityArray = try JSONDecoder().decode(
            [DecodableCountry].self,
            from: data
        )
        guard let capitalCity = capitalCityArray.first?.capital.first else {
            throw QueryResponseError.decoding
        }
        
        return QueryResponse(responseString: capitalCity)
    }
}
