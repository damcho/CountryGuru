//
//  CountryPrenomQuestion+networkExtension.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 17/3/25.
//

import Foundation

struct DecodableCommonName: Decodable {
    let common: String
}

struct DecodableCountryName: Decodable {
    let name: DecodableCommonName
}

// MARK: - CountryPrenomQuestion + Inquiry

extension CountryPrenomQuestion: Inquiry {
    func mappedResponse(from data: Data, httpURLResponse: HTTPURLResponse) throws -> QueryResponse {
        guard httpURLResponse.statusCode == 200 else {
            throw HTTPClientError.notFound
        }
        let countryNames = try JSONDecoder().decode(
            [DecodableCountryName].self,
            from: data
        )
        let filteredCountries = countryNames.filter { decodableCountryName in
            decodableCountryName.name.common.lowercased().hasPrefix(countryPrenom.lowercased())
        }.map { filteredCountry in filteredCountry.name.common }

        guard !filteredCountries.isEmpty else {
            return .multiple(["No countries match with your query"])
        }
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
