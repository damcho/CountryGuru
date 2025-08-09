//
//  main.swift
//  CountryGuruCLI
//
//  Created by Damian Modernell on 16/3/25.
//

import Foundation
import CountryGuruCore

let questionHandler = CountryGuruComposer.compose()

print("Welcome to Country Guru, please ask your country question below")
while let question = readLine() {
    Task {
        do {
            let reply = try await questionHandler.didAskRaw(question)
            switch reply {
            case .text(let response):
                print(response)
            case .multiple(let multipleResponses):
                multipleResponses.forEach { print($0) }
            default: break
            }
        } catch is InquiryInterpreterError {
            print("I could not understand or I am unable to respond this type of question")
        } catch {
            print("An unexpected error occurred while processing your question")
        }
    }
}

RunLoop.current.run()


