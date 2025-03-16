//
//  CountryGuruComposer.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 15/3/25.
//

import Foundation

public enum CountryGuruComposer {
    static let dataSourceURL = URL(string: "https://restcountries.com/v3.1")!
    static let httpClient = URLSessionHTTPClient(session: .shared)
    
    public static let inquiriesMap = [
        CountryCapitalQuestion.question: {
            countryName in CountryCapitalQuestion(countryName: countryName) as Inquiry}
    ]
    
    static func compose(
        with httpClient: HTTPClient,
        supportedQuestions: [String: InquiryCreator]
    ) -> QuestionInterpreterAdapter {
        let adapter = QuestionInterpreterAdapter(
            inquiryLoader: RemoteInquiryLoader(
                httpClient: httpClient,
                baseURL: dataSourceURL
            ),
            inquiryInterpreter: BasicQuestionInterpreter(
                supportedInquiries: supportedQuestions
            )
        )
        return adapter
    }
    
    public static func compose(with inquiries: [String: InquiryCreator] = inquiriesMap) -> QuestionHandable {
        compose(with: httpClient, supportedQuestions: inquiries)
    }
}
