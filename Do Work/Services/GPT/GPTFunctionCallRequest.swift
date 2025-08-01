//
//  GPTFunctionCallPayload.swift
//  Do Work
//
//  Created by Chance Martinez on 7/31/25.
//

import Foundation

struct GPTFunctionCallRequest: Codable {
    let model: String
    let messages: [Message]
    let functions: [FunctionDefinition]?
    let function_call: FunctionCallDirective?
}

struct Message: Codable {
    let role: String
    let content: String
}

struct FunctionDefinition: Codable {
    let name: String
    let description: String
    let arguments: [String: AnyCodable]
}

enum FunctionCallDirective: Codable, Equatable {
    case auto
    case named(String)

    enum CodingKeys: String, CodingKey {
        case name
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .auto:
            try container.encode("auto")
        case .named(let name):
            try container.encode(["name": name])
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self), string == "auto" {
            self = .auto
        } else if let dict = try? container.decode([String: String].self),
                  let name = dict["name"] {
            self = .named(name)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid function_call format")
        }
    }
}
