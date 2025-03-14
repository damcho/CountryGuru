//
//  InquiryLoaderDecoratorTests.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 13/3/25.
//

import Testing
@testable import CountryGuruCore

struct InquiryLoaderDecoratorTests {

    @Test func throws_on_query_error() async throws {
        let sut = makeSUT(stub: .failure(.timeout))

        await #expect(throws: HTTPClientError.timeout, performing: {
            try await sut.didAsk(anyQuestion)
        })
    }
    
    @Test func maps_data_on_successful_loaded_response() async throws {
        let sut = makeSUT(stub: .success((anyHTTPURLResponse(), anyData)))
        let inquirySpy = DummyInquirySpy()
        _ = try await sut.didAsk(inquirySpy)
        
        #expect(inquirySpy.mappedResponseMessages == [anyData])
    }
}

extension InquiryLoaderDecoratorTests {
    func makeSUT(stub: Result<(HTTPURLResponse, Data), HTTPClientError>) -> RemoteInquiryLoaderDecorator {
        RemoteInquiryLoaderDecorator(
            httpClient: HTTPClientStub(result: stub),
            baseURL: anyURL
        )
    }
}

struct HTTPClientStub: HTTPClient {
    let result: Result<(HTTPURLResponse, Data), HTTPClientError>
    func load(url: URL) async throws(HTTPClientError) -> (HTTPURLResponse, Data) {
        try result.get()
    }
}

struct InquiryLoaderStub: InquiryLoadable {
    let stub: Result<QueryResponse, Error>
    
    func didAsk(_ question: Inquiry) async throws -> (QueryResponse) {
        try stub.get()
    }
}

final class DummyInquirySpy: Inquiry {
    var mappedResponseMessages: [Data] = []

    func makeURL(from baseURL: URL) -> URL {
        baseURL
    }
    
    func mappedResponse(from data: Data) throws -> QueryResponse {
        mappedResponseMessages.append(data)
        return anyQueryResponse
    }
}

var anyQuestion: Inquiry {
    CountryCapitalQuestion(countryName: "Argentina")
}

var anyQueryResponse: QueryResponse {
    .init(responseString: "Buenos Aires")
}

var anyURL: URL {
    URL(string: "http://any-url.com")!
}

func anyHTTPURLResponse() -> HTTPURLResponse {
    return HTTPURLResponse(url: anyURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
}

var anyData: Data {
    Data("any data".utf8)
}

