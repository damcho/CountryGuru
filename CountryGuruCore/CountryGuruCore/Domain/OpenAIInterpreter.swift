//
//  OpenAIInterpreter.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 17/3/25.
//

import Foundation

/// OpenAIInterpreter uses ChatGPT to classify user questions into inquiry types
/// and then creates the appropriate Inquiry object based on the classification.
struct OpenAIInterpreter {
    private let apiKey: String
    private let inquiries: [AnyInquiry]
    private let httpClient: HTTPClient

    /// Creates an OpenAIInterpreter with the specified API key, supported inquiries, and HTTP client
    init(apiKey: String, inquiries: [AnyInquiry], httpClient: HTTPClient) {
        self.apiKey = apiKey
        self.inquiries = inquiries
        self.httpClient = httpClient
    }

    private func createSystemPrompt() -> String {
        let classifications = inquiries.map { $0.questionType.rawValue }.joined(separator: "|")
        return """
        Classify: \(classifications)|not_supported
        Format: {"type":"category","domain":"extracted_text"}
        Examples: "capital of France"→{"type":"\(
            InquiryType
                .countryCapital
        )","domain":"France"}, "ISO alpha-2 code of Japan"→{"type":"\(
            InquiryType
                .countryISOalpha2code
        )","domain":"Japan"}, "countries start with BR"→{"type":"\(
            InquiryType
                .countryPrenom
        )","domain":"BR"}
        JSON only.
        """
    }

    private func classifyQuestion(_ question: String) async throws -> (type: String, domain: String) {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!

        let requestBody = OpenAIRequest(
            model: "gpt-3.5-turbo",
            messages: [
                Message(role: "system", content: createSystemPrompt()),
                Message(role: "user", content: question)
            ],
            max_tokens: 50,
            temperature: 0.1
        )

        let bodyData = try JSONEncoder().encode(requestBody)

        let (httpResponse, data) = try await httpClient.post(
            url: url,
            body: bodyData,
            headers: [HTTPHeader.authorization(apiKey), HTTPHeader.contentType("application/json")]
        )
        let response = try JSONDecoder().decode(OpenAIResponse.self, from: data)

        guard let content = response.choices.first?.message.content else {
            throw InquiryInterpreterError.notSupported
        }

        let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)

        // Parse the JSON response
        guard
            let jsonData = trimmedContent.data(using: .utf8),
            let classification = try? JSONDecoder().decode(ClassificationResponse.self, from: jsonData)
        else {
            throw InquiryInterpreterError.notSupported
        }

        return (type: classification.type, domain: classification.domain)
    }
}

// MARK: InquiryInterpreter

extension OpenAIInterpreter: InquiryInterpreter {
    public func inquiry(from question: String) async throws -> any Inquiry {
        let (
            classificationType,
            domain
        ) = try await classifyQuestion(question.trimmingCharacters(in: .whitespacesAndNewlines))

        guard
            let matchedInquiry = inquiries.first(where: { inquiry in
                inquiry.questionType.rawValue == classificationType
            })
        else {
            throw InquiryInterpreterError.notSupported
        }

        return matchedInquiry.inquiryCreator(domain)
    }
}

// MARK: OpenAI API Models

private struct OpenAIRequest: Codable {
    let model: String
    let messages: [Message]
    let max_tokens: Int
    let temperature: Double
}

private struct Message: Codable {
    let role: String
    let content: String
}

private struct OpenAIResponse: Codable {
    let choices: [Choice]
}

private struct Choice: Codable {
    let message: Message
}

private struct ClassificationResponse: Codable {
    let type: String
    let domain: String
}
