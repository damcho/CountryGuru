//
//  CountryGuruCoreTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 10/3/25.
//

import Testing
@testable import CountryGuruCore
import Foundation

struct QueryResponse: Equatable {
    let responseString: String
}

enum QueryResponseError: Error {
    case decoding
}

struct DecodableCountry: Decodable {
    let capital: [String]
}

struct CountryCapitalQuestion {
    let countryName: String
    
    var queryPath: String {
        return "/name/\(countryName)"
    }
    
    func mappedResponse(from data: Data) throws -> QueryResponse {
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

struct CountryGuruCoreTests {

    @Test func country_capital_query_path() async throws {
        let aCountry = "aCountry"
        let sut = CountryCapitalQuestion(countryName: aCountry)
        
        #expect(sut.queryPath == "/name/\(aCountry)")
    }
    
    @Test func throws_on_mapping_query_response_error() async throws {
        let aCountry = "aCountry"
        let invalidData = "invalidData".data(using: .utf8)!
        let sut = CountryCapitalQuestion(countryName: aCountry)

        #expect(throws: anyError, performing: {
            try sut.mappedResponse(from: invalidData)
        })
    }
    
    @Test func maps_response_successfully() async throws {
        let aCountry = "Argentina"
        let sut = CountryCapitalQuestion(countryName: aCountry)

        #expect(try sut.mappedResponse(from: countryCapital.http) == countryCapital.domain)
    }

}

var anyError: NSError {
    NSError(domain: "", code: 0, userInfo: nil)
}

var countryCapital: (http: Data, domain: QueryResponse) {
    (
        #"[{"capital": ["Buenos Aires"]}]"#.data(using: .utf8)!,
        QueryResponse(responseString: "Buenos Aires")
    )
}
