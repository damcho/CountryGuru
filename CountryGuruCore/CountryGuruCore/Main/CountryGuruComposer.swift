//
//  CountryGuruComposer.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 15/3/25.
//

import Foundation

enum CountryGuruComposer {
    static let dataSourceURL = URL(string: "https://restcountries.com/v3.1/")!
    
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
}
