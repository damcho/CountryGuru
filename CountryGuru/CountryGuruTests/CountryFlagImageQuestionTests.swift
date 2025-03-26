//
//  CountryFlagImageQuestionTests.swift
//  CountryGuruTests
//
//  Created by Damian Modernell on 25/3/25.
//

import Testing
import CountryGuruCore

struct DecodableCountryFlagImage: Decodable {
    let png: String
}
struct DecodableCountryFlagImageRoot: Decodable {
    let flags: DecodableCountryFlagImage
}


class CountryFlagImageQuestion: CountryFlagQuestion {
    override func makeURL(from baseURL: URL) -> URL {
        baseURL
            .appendingPathComponent("name/\(countryName)")
            .appending(queryItems: [URLQueryItem(name: "fields", value: "flags")])
    }
    
    override func mappedResponse(from data: Data) throws -> QueryResponse {
        let decodedCountryFlagImage = try JSONDecoder().decode(
            [DecodableCountryFlagImageRoot].self,
            from: data
        )
        guard let decodedFlag = decodedCountryFlagImage.first?.flags.png,
              let decodedFlagUrl = URL(string: decodedFlag) else {
            throw QueryResponseError.decoding
        }
        
        return .image(decodedFlagUrl)
    }
}

struct CountryFlagImageQuestionTests {

    @Test func query_path() async throws {
        let aCountry = "aCountry"

        #expect(anyCountryFlagQuestion(for: aCountry).makeURL(from: anyURL).absoluteString == "\(anyURL.absoluteString)/name/\(aCountry)?fields=flags")
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
    CountryFlagImageQuestion(countryName: countryName)
}

var countryFlag: (http: Data, domain: QueryResponse) {
    (
        #"[{"flags": {"png": "https://flagcdn.com/w320/br.png"}}]"#.data(using: .utf8)!,
        .image(URL(string: "https://flagcdn.com/w320/br.png")!)
    )
}
