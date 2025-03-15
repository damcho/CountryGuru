//
//  URLSessionHTTPClient+extension.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 15/3/25.
//

import Foundation

extension URLSessionHTTPClient: HTTPClient {
    public func load(url: URL) async throws(HTTPClientError) -> (HTTPURLResponse, Data) {
        let result = await withCheckedContinuation { continuation in
            _ = get(from: url) { result in
                continuation.resume(returning: result)
            }
        }

        do {
            let aResult = try result.get()
            return (aResult.1, aResult.0)
        } catch {
            throw .timeout
        }
    }
}
