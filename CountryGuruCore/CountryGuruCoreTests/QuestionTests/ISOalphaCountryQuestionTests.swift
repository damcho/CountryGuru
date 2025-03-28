//
//  ISOalphaCountryQuestionTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 28/3/25.
//

import Testing
@testable import CountryGuruCore

struct ISOalpha2CountryQuestion: Inquiry {
    let countryName: String
    func mappedResponse(from data: Data, httpURLResponse: HTTPURLResponse) throws -> QueryResponse {
        throw anyError
    }
    
    var queryItems: [URLQueryItem] {
        [URLQueryItem(name: "fields", value: "cca2")]
    }
    
    var queryPath: String {
        return "/name/\(countryName)"
    }
    
    func makeURL(from baseURL: URL) -> URL {
        baseURL
            .appendingPathComponent(queryPath)
            .appending(queryItems: queryItems)
    }
}

struct ISOalphaCountryQuestionTests: InquirySpecs {
    @Test func query_path() async throws {
        let aCountry = "aCountry"
        let sut = ISOalpha2CountryQuestion(countryName: aCountry)
        
        #expect(sut.makeURL(from: anyURL).absoluteString == "\(anyURL.absoluteString)/name/\(aCountry)?fields=cca2")
    }
    
    @Test func throws_on_mapping_query_response_error() async throws {
        
    }
    
    @Test func maps_response_successfully() async throws {
        
    }
    
    @Test func throws_not_found_on_404_http_response() async throws {
        
    }
}
