//
//  CountryPrenomQuestionTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 17/3/25.
//

import Testing

@testable import CountryGuruCore

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
        let countryNameData = #"[{"name": {"common": "Argentina"}}]"#.data(using: .utf8)!
        #expect(try anyCountryPrenomQUestion.mappedResponse(from: countryNameData) == .multiple( ["Argentina"]))
    }
}

var anyCountryPrenomQUestion: CountryPrenomQuestion {
    CountryPrenomQuestion(countryPrenom: "Ar")
}
