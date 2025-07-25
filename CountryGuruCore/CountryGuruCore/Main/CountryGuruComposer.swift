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

    public static let iso2CountryInquiry = (
        key: ISOalpha2CountryQuestion.question,
        factory: { countryName in
            ISOalpha2CountryQuestion(countryName: countryName) as Inquiry
        }
    )

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

    public static let inquiriesArray = [
        AnyInquiry(
            question: countryCapitalInquiry.key,
            inquiryCreator: countryCapitalInquiry.factory
        ),
        AnyInquiry(
            question: countryPrenomInquiry.key,
            inquiryCreator: countryPrenomInquiry.factory
        ),
        AnyInquiry(
            question: countryFlagInquiry.key,
            inquiryCreator: countryFlagInquiry.factory
        ),
        AnyInquiry(
            question: iso2CountryInquiry.key,
            inquiryCreator: iso2CountryInquiry.factory
        )
    ]

    static func compose(
        with httpClient: HTTPClient,
        supportedQuestions: [AnyInquiry]
    )
        -> QuestionInterpreterAdapter
    {
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

    public static func compose(with inquiries: [AnyInquiry] = inquiriesArray) -> QuestionHandable {
        compose(with: httpClient, supportedQuestions: inquiries)
    }
}
