//
//  CountryFlagTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 17/3/25.
//

import Testing
@testable import CountryGuruCore

struct CountryFlagQuestionTests: InquirySpecs {
    @Test func query_path() async throws {
        let aCountry = "aCountry"

        #expect(anyCountryFlagQuestion(for: aCountry).makeURL(from: anyURL).absoluteString == "\(anyURL.absoluteString)/name/\(aCountry)?fields=flag")
    }
    
    @Test func throws_on_mapping_query_response_error() async throws {
        let aCountry = "aCountry"
        let invalidData = "invalidData".data(using: .utf8)!
        let sut = anyCountryFlagQuestion(for: aCountry)

        #expect(throws: DecodingError.self, performing: {
            try sut.mappedResponse(from: invalidData)
        })
    }
    
    @Test func maps_response_successfully() async throws {
        let aCountry = "Argentina"
        let sut = anyCountryFlagQuestion(for: aCountry)

        #expect(try sut.mappedResponse(from: countryFlag.http) == countryFlag.domain)
    }
}

func anyCountryFlagQuestion(for countryName: String) -> CountryFlagQuestion {
    CountryFlagQuestion(countryName: countryName)
}

var countryFlag: (http: Data, domain: QueryResponse) {
    (
        #"[{"flag": "🇦🇷"}]"#.data(using: .utf8)!,
        .text("🇦🇷")
    )
}
