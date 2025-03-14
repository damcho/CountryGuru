//
//  RemoteInquiryLoaderDecorator.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 14/3/25.
//

import Foundation

struct RemoteInquiryLoader {
    let httpClient: HTTPClient
    let baseURL: URL
}

extension RemoteInquiryLoader: InquiryLoadable {
    func didAsk(_ question: Inquiry) async throws -> QueryResponse {
        let (_, data) = try await httpClient.load(
            url: question.makeURL(from: baseURL)
        )
        return try question.mappedResponse(from: data)
    }
}
