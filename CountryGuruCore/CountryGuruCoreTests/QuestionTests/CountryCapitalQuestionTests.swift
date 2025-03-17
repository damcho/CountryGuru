//
//  CountryGuruCoreTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 10/3/25.
//

import Testing
@testable import CountryGuruCore
import Foundation

protocol InquirySpecs {
    func query_path() async throws
    func throws_on_mapping_query_response_error() async throws
    func maps_response_successfully() async throws
}

struct CountryCapitalQuestionTests: InquirySpecs {

    @Test func query_path() async throws {
        let aCountry = "aCountry"
        let sut = CountryCapitalQuestion(countryName: aCountry)
        
        #expect(sut.makeURL(from: anyURL).absoluteString == "\(anyURL.absoluteString)/name/\(aCountry)?fields=capital")
    }
    
    @Test func throws_on_mapping_query_response_error() async throws {
        let aCountry = "aCountry"
        let invalidData = "invalidData".data(using: .utf8)!
        let sut = CountryCapitalQuestion(countryName: aCountry)

        #expect(throws: DecodingError.self, performing: {
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
