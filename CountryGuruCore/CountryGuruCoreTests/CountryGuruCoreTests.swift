//
//  CountryGuruCoreTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 10/3/25.
//

import Testing
@testable import CountryGuruCore

struct QueryResponse {
    
}

struct CountryCapitalQuestion {
    let countryName: String
    
    var queryPath: String {
        return "/name/\(countryName)"
    }
    
    var responseMapper: (Data) throws -> QueryResponse {
        { _ in throw anyError }
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
            try sut.responseMapper(invalidData)
        })
    }

}

var anyError: NSError {
    NSError(domain: "", code: 0, userInfo: nil)
}
