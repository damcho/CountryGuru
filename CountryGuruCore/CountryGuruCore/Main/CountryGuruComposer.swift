//
//  CountryGuruComposer.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 15/3/25.
//

import Foundation

public enum CountryGuruComposer {
    static let dataSourceURL = URL(string: "https://restcountries.com/v3.1/")!
    static let httpClient = URLSessionHTTPClient(session: .shared)
    
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
    
    public static func compose(with inquiries: [String: InquiryCreator]) -> QuestionHandable {
        compose(with: httpClient, supportedQuestions: inquiries)
    }
}
