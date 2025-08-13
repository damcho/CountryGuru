//
//  URLSessionHTTPClient+extension.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 15/3/25.
//

import Foundation

extension URLSessionHTTPClient: HTTPClient {
    private func mapError(_ error: Error) -> HTTPClientError {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .timedOut:
                HTTPClientError.timeout
            case .notConnectedToInternet, .networkConnectionLost:
                HTTPClientError.serverError
            case .badServerResponse:
                HTTPClientError.serverError
            case .badURL:
                HTTPClientError.invalidRequest
            default:
                HTTPClientError.serverError
            }
        } else {
            HTTPClientError.other
        }
    }

    func post(url: URL, body: Data, headers: [HTTPHeader]) async throws(HTTPClientError) -> (HTTPURLResponse, Data) {
        let headerDict = headers.reduce(into: [String: String]()) { result, header in
            result[header.name] = header.value
        }

        do {
            return try await post(url: url, body: body, headers: headerDict)
        } catch {
            throw mapError(error)
        }
    }

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
            throw mapError(error)
        }
    }
}
