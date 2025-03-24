//
//  CountryPrenomQuestion+networkExtension.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 17/3/25.
//

import Foundation

struct DecodableOfficialName: Decodable {
    let official: String
}

struct DecodableCountryName: Decodable {
    let name: DecodableOfficialName
}

extension CountryPrenomQuestion: Inquiry {
    func mappedResponse(from data: Data) throws -> QueryResponse {
        let countryNames = try JSONDecoder().decode(
            [DecodableCountryName].self,
            from: data
        )
        let filteredCountries = countryNames.filter { decodableCountryName in
            decodableCountryName.name.official.lowercased().hasPrefix(countryPrenom.lowercased())
        }.map({ filteredCountry in filteredCountry.name.official })
        
        return .multiple(filteredCountries)
    }
    
    func makeURL(from baseURL: URL) -> URL {
        baseURL
            .appendingPathComponent("all")
            .appending(
                queryItems: [URLQueryItem(name: "fields", value: "name")]
            )
    }
}
