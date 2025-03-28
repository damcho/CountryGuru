//
//  ISOalphaCountryQuestionTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 28/3/25.
//

import Testing
@testable import CountryGuruCore

struct ISOalphaCountryQuestionTests: InquirySpecs {
    @Test func query_path() async throws {
        let aCountry = "aCountry"
        let sut = ISOalpha2CountryQuestion(countryName: aCountry)
        
        #expect(sut.makeURL(from: anyURL).absoluteString == "\(anyURL.absoluteString)/name/\(aCountry)?fields=cca2")
    }
    
    @Test func throws_on_mapping_query_response_error() async throws {
        let aCountry = "aCountry"
        let invalidData = "invalidData".data(using: .utf8)!
        let sut = ISOalpha2CountryQuestion(countryName: aCountry)

        #expect(throws: DecodingError.self, performing: {
            try sut.mappedResponse(from: invalidData, httpURLResponse: validHTTPURLResponse)
        })
    }
    
    @Test func maps_response_successfully() async throws {
        let aCountry = "Argentina"
        let sut = ISOalpha2CountryQuestion(countryName: aCountry)

        #expect(try sut.mappedResponse(from: cca2.http, httpURLResponse: validHTTPURLResponse) == cca2.domain)
    }
    
    @Test func throws_not_found_on_404_http_response() async throws {
        let aCountry = "aCountry"
        let sut = ISOalpha2CountryQuestion(countryName: aCountry)
        
        #expect(throws: HTTPClientError.notFound, performing: {
            try sut.mappedResponse(from: anyData, httpURLResponse: notFOundHTTPRsponse)
        })
    }
}

var cca2: (http: Data, domain: QueryResponse) {
    (
        #"[{"cca2": "AR"}]"#.data(using: .utf8)!,
        .text( "AR")
    )
}
