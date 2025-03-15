//
//  TestHelpers.swift
//  CountryGuruCoreTests
//
//  Created by Damian Modernell on 15/3/25.
//

import Foundation


public var anyNSError: NSError {
    NSError(domain: "any error", code: 0)
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


