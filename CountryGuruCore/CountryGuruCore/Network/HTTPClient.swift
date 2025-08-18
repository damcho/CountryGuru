//
//  HTTPClient.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 14/3/25.
//

import Foundation

public enum HTTPClientError: Error {
    case timeout
    case notFound
    case invalidRequest
    case serverError
    case other
}

struct HTTPHeader {
    let name: String
    let value: String

    init(name: String, value: String) {
        self.name = name
        self.value = value
    }

    static func authorization(_ token: String) -> HTTPHeader {
        HTTPHeader(name: "Authorization", value: "Bearer \(token)")
    }

    static func contentType(_ type: String) -> HTTPHeader {
        HTTPHeader(name: "Content-Type", value: type)
    }

    static func accept(_ type: String) -> HTTPHeader {
        HTTPHeader(name: "Accept", value: type)
    }
}

protocol HTTPClient {
    func load(url: URL) async throws(HTTPClientError) -> (HTTPURLResponse, Data)
    func post(url: URL, body: Data, headers: [HTTPHeader]) async throws(HTTPClientError) -> (HTTPURLResponse, Data)
}
