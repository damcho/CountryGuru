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

    public static let iso2CountryInquiry =
        AnyInquiry(
            question: ISOalpha2CountryQuestion.question,
            inquiryCreator: { countryName in
                ISOalpha2CountryQuestion(countryName: countryName) as Inquiry
            }
        )

    public static let countryFlagInquiry =
        AnyInquiry(
            question: CountryFlagQuestion.question,
            inquiryCreator: { countryName in
                CountryFlagQuestion(countryName: countryName) as Inquiry
            }
        )

    public static let countryCapitalInquiry =
        AnyInquiry(
            question: CountryCapitalQuestion.question,
            inquiryCreator: { countryName in
                CountryCapitalQuestion(countryName: countryName) as Inquiry
            }
        )

    public static let countryPrenomInquiry =
        AnyInquiry(
            question: CountryPrenomQuestion.question,
            inquiryCreator: { countryNamePrefix in
                CountryPrenomQuestion(countryPrenom: countryNamePrefix) as Inquiry
            }
        )

    public static let inquiriesArray = [
        countryCapitalInquiry,
        countryFlagInquiry,
        countryPrenomInquiry,
        iso2CountryInquiry
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
