//
//  CountryGuruCoreTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 10/3/25.
//

import Testing
@testable import CountryGuruCore

struct CountryCapitalQuestion {
    let countryName: String
    
    var queryPath: String {
        return "/name/\(countryName)"
    }
}

struct CountryGuruCoreTests {

    @Test func country_capital_query_path() async throws {
        let aCountry = "aCountry"
        let sut = CountryCapitalQuestion(countryName: aCountry)
        
        #expect(sut.queryPath == "/name/\(aCountry)")
    }

}
