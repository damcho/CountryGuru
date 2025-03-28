//
//  CountryFlagImageQuestionTests.swift
//  CountryGuruTests
//
//  Created by Damian Modernell on 25/3/25.
//

import Testing
import CountryGuruCore
@testable import CountryGuru

struct CountryFlagImageQuestionTests {
    @Test func throws_not_found_on_404_http_response() async throws {
        let aCountry = "aCountry"

        #expect(throws: HTTPClientError.notFound, performing: {
            try anyCountryFlagQuestion(for: aCountry).mappedResponse(from: anyData, httpURLResponse: notFOundHTTPRsponse)
        })
    }
    
    @Test func query_path() async throws {
        let aCountry = "aCountry"

        #expect(anyCountryFlagQuestion(for: aCountry).makeURL(from: anyURL).absoluteString == "\(anyURL.absoluteString)/name/\(aCountry)?fields=flags")
    }
    
    @Test func throws_on_mapping_query_response_error() async throws {
        let aCountry = "aCountry"
        let invalidData = "invalidData".data(using: .utf8)!
        let sut = anyCountryFlagQuestion(for: aCountry)

        #expect(throws: DecodingError.self, performing: {
            try sut.mappedResponse(from: invalidData, httpURLResponse: validHTTPURLResponse)
        })
    }
    
    @Test func maps_response_successfully() async throws {
        let aCountry = "Argentina"
        let sut = anyCountryFlagQuestion(for: aCountry)

        #expect(try sut.mappedResponse(from: countryFlag.http, httpURLResponse: validHTTPURLResponse) == countryFlag.domain)
    }

}

func anyCountryFlagQuestion(for countryName: String) -> CountryFlagQuestion {
    CountryFlagImageQuestion(countryName: countryName)
}

var countryFlag: (http: Data, domain: QueryResponse) {
    (
        #"[{"flags": {"png": "https://flagcdn.com/w320/br.png"}}]"#.data(using: .utf8)!,
        .image(URL(string: "https://flagcdn.com/w320/br.png")!)
    )
}

var validHTTPURLResponse: HTTPURLResponse {
    .init(url: URL(string: "https://restcountries.eu/")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
}

var notFOundHTTPRsponse: HTTPURLResponse {
    .init(url: URL(string: "https://restcountries.eu/")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
}

var anyData: Data { Data() }
