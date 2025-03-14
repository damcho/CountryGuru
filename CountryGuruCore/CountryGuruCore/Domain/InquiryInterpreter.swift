//
//  InquiryInterpreter.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 14/3/25.
//

protocol InquiryInterpreter {
    func inquiry(from question: String) throws -> any Inquiry
}
