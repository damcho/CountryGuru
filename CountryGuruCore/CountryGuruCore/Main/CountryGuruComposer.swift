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
    
    public static let countryFlagInquiry = (
        key: CountryFlagQuestion.question,
        factory: { countryName in
            CountryFlagQuestion(countryName: countryName) as Inquiry
        }
    )
    
    public static let countryCapitalInquiry = (
        key: CountryCapitalQuestion.question,
        factory: { countryName in
            CountryCapitalQuestion(countryName: countryName) as Inquiry
        }
    )
    
    public static let countryPrenomInquiry = (
        key: CountryPrenomQuestion.question,
        factory: { countryNamePrefix in
            CountryPrenomQuestion(countryPrenom: countryNamePrefix) as Inquiry
        }
    )
    
    public static let inquiriesMap = [
        countryCapitalInquiry.key: countryCapitalInquiry.factory,
        countryPrenomInquiry.key: countryPrenomInquiry.factory,
        countryFlagInquiry.key: countryFlagInquiry.factory
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
