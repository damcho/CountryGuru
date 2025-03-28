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
            try anyCountryPrenomQUestion.mappedResponse(from: invalidData, httpURLResponse: validHTTPURLResponse)
        })
    }
    
    @Test func maps_response_successfully() async throws {
        let countryNameData = #"[{"name": {"common": "Argentina"}}]"#.data(using: .utf8)!
        #expect(try anyCountryPrenomQUestion.mappedResponse(from: countryNameData, httpURLResponse: validHTTPURLResponse) == .multiple( ["Argentina"]))
    }
    
    @Test func returns_emtpy_response_message_on_empty_data() async throws {
        let countryNameData = #"[]"#.data(using: .utf8)!
        #expect(try anyCountryPrenomQUestion.mappedResponse(from: countryNameData, httpURLResponse: validHTTPURLResponse) == .multiple( ["No countries match with your query"]))
    }
}

var anyCountryPrenomQUestion: CountryPrenomQuestion {
    CountryPrenomQuestion(countryPrenom: "Ar")
}
