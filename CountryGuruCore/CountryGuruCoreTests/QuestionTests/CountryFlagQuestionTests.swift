//
//  CountryFlagTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 17/3/25.
//

import Testing
@testable import CountryGuruCore

class CountryFlagQuestion: Inquiry {
    let countryName: String
    
    init(countryName: String) {
        self.countryName = countryName
    }
    
    func mappedResponse(from data: Data) throws -> QueryResponse {
        anyQueryResponse
    }
    
    func makeURL(from baseURL: URL) -> URL {
        baseURL
            .appendingPathComponent("name/\(countryName)")
            .appending(queryItems: [URLQueryItem(name: "fields", value: "flag")])
    }
}


struct CountryFlagQuestionTests: InquirySpecs {
    @Test func query_path() async throws {
        let aCountry = "aCountry"

        #expect(anyCountryFlagQuestion(for: aCountry).makeURL(from: anyURL).absoluteString == "\(anyURL.absoluteString)/name/\(aCountry)?fields=flag")
    }
    
    @Test func throws_on_mapping_query_response_error() async throws {
     
    }
    
    @Test func maps_response_successfully() async throws {
        
    }
}

func anyCountryFlagQuestion(for countryName: String) -> CountryFlagQuestion {
    CountryFlagQuestion(countryName: countryName)
}
