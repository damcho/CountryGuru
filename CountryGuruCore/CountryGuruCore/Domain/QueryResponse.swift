//
//  QueryResponse.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 15/3/25.
//

import Foundation

public enum QueryResponse: Equatable {
    case text(String)
    case image(URL)
    case multiple([String])
}
