//
//  CountryPrenomQuestionTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 17/3/25.
//

import Testing

@testable import CountryGuruCore

struct DecodableOfficialName: Decodable {
    let official: String
}

struct DecodableCountryName: Decodable {
    let name: DecodableOfficialName
}

struct CountryPrenomQuestion {
    let countryPrenom: String
}

extension CountryPrenomQuestion: Inquiry {
    func mappedResponse(from data: Data) throws -> QueryResponse {
        let countryNames = try JSONDecoder().decode(
            [DecodableCountryName].self,
            from: data
        )
        let filteredCountries = countryNames.filter { decodableCountryName in
            decodableCountryName.name.official.hasPrefix(countryPrenom)
        }.reduce("") { partialResult, decodableCountry in
            partialResult.appending("\(decodableCountry.name.official)\n")
        }
        
        return QueryResponse(responseString: filteredCountries)
    }
    
    func makeURL(from baseURL: URL) -> URL {
        baseURL
            .appendingPathComponent("all")
            .appending(
                queryItems: [URLQueryItem(name: "fields", value: "name")]
            )
    }
}

struct CountryPrenomQuestionTests: InquirySpecs {
    @Test func query_path() async throws {
        #expect(anyCountryPrenomQUestion.makeURL(from: anyURL).absoluteString == "\(anyURL.absoluteString)/all?fields=name")
    }
    
    @Test func throws_on_mapping_query_response_error() async throws {
        let invalidData = "invalidData".data(using: .utf8)!

        #expect(throws: DecodingError.self, performing: {
            try anyCountryPrenomQUestion.mappedResponse(from: invalidData)
        })
    }
    
    @Test func maps_response_successfully() async throws {
        let countryNameData = #"[{"name": {"official": "Argentina"}}]"#.data(using: .utf8)!
        #expect(try anyCountryPrenomQUestion.mappedResponse(from: countryNameData) == QueryResponse(responseString: "Argentina\n"))
    }
}

var anyCountryPrenomQUestion: CountryPrenomQuestion {
    CountryPrenomQuestion(countryPrenom: "Ar")
}
