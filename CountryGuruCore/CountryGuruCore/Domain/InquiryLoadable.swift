//
//  InquiryLoadable.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 14/3/25.
//

import Foundation

protocol InquiryLoadable {
    func didAsk(_ question: Inquiry) async throws -> QueryResponse
}
