//
//  ISOalphaCountryQuestionTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 28/3/25.
//

import Testing
@testable import CountryGuruCore

struct DecodableAlpha2Code: Decodable {
    let cca2: String
}

struct ISOalpha2CountryQuestion: Inquiry {
    let countryName: String
    func mappedResponse(from data: Data, httpURLResponse: HTTPURLResponse) throws -> QueryResponse {
        guard httpURLResponse.statusCode == 200 else {
            throw HTTPClientError.notFound
        }
        let capitalCityArray = try JSONDecoder().decode(
            [DecodableAlpha2Code].self,
            from: data
        )
        guard let cca2 = capitalCityArray.first?.cca2 else {
            throw QueryResponseError.decoding
        }
        
        return .text(cca2)
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
