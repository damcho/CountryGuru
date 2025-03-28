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
}

protocol HTTPClient {
    func load(url: URL) async throws(HTTPClientError) -> (HTTPURLResponse, Data)
}
