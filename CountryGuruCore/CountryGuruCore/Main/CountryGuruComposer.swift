//
//  CountryGuruComposer.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 15/3/25.
//

import CoreML
import Foundation

public enum CountryGuruComposer {
    static var openAIAPIKey: String {
        ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? ""
    }

    static let dataSourceURL = URL(string: "https://restcountries.com/v3.1")!
    nonisolated(unsafe) static let httpClient = URLSessionHTTPClient(session: .shared)

    public static let iso2CountryInquiry =
        AnyInquiry(
            questionType: ISOalpha2CountryQuestion.type,
            inquiryCreator: { countryName in
                ISOalpha2CountryQuestion(countryName: countryName) as Inquiry
            }
        )

    public static let countryFlagInquiry =
        AnyInquiry(
            questionType: CountryFlagQuestion.type,
            inquiryCreator: { countryName in
                CountryFlagQuestion(countryName: countryName) as Inquiry
            }
        )

    public static let countryCapitalInquiry =
        AnyInquiry(
            questionType: CountryCapitalQuestion.type,
            inquiryCreator: { countryName in
                CountryCapitalQuestion(countryName: countryName) as Inquiry
            }
        )

    public static let countryPrenomInquiry =
        AnyInquiry(
            questionType: CountryPrenomQuestion.type,
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
        assert(
            !openAIAPIKey.isEmpty,
            "OPENAI_API_KEY is missing. Set it in your Scheme (Run/Test > Arguments > Environment) or CI secrets."
        )
        let adapter = QuestionInterpreterAdapter(
            inquiryLoader: RemoteInquiryLoader(
                httpClient: httpClient,
                baseURL: dataSourceURL
            ),
            inquiryInterpreter: OpenAIInterpreter(
                apiKey: openAIAPIKey,
                inquiries: supportedQuestions,
                httpClient: httpClient
            )
        )
        return adapter
    }

    public static func compose(with inquiries: [AnyInquiry] = inquiriesArray) -> QuestionHandable {
        compose(with: httpClient, supportedQuestions: inquiries)
    }
}
