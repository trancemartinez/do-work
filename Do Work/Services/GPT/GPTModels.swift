//
//  GPTModels.swift
//  Do Work
//
//  Created by Chance Martinez on 7/31/25.
//

struct GPTCommand: Codable {
    let action: String
    let target: String?
    let parameters: [String: AnyCodable]
}

struct GPTResponse: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]

    struct Choice: Codable {
        let index: Int
        let message: Message
        let finish_reason: String?
    }

    struct Message: Codable {
        let role: String
        let content: String?
        let function_call: FunctionCall?
    }

    struct FunctionCall: Codable {
        let name: String
        let arguments: String
    }
}

struct ValidationError: Error, Codable {
    let message: String
    let code: Int?
}
