//
//  Inquiry.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 17/3/25.
//

public protocol Inquiry {
    func mappedResponse(from data: Data) throws -> QueryResponse
    func makeURL(from baseURL: URL) -> URL
}
