//
//  GPTIntegrationTests.swift
//  Do Work
//
//  Created by Chance Martinez on 8/1/25.
//


@testable import Do_Work
import XCTest

final class GPTIntegrationTests: XCTestCase {

    // MARK: - GPTFunctionCallRequest

    func testGPTFunctionCallRequestEncodingDecoding() throws {
        let message = Message(role: "user", content: "What's the weather?")
        let function = FunctionDefinition(
            name: "getWeather",
            description: "Fetch weather info",
            arguments: ["location": AnyCodable("Paris")]
        )
        let request = GPTFunctionCallRequest(
            model: "gpt-4.1",
            messages: [message],
            functions: [function],
            function_call: .named("getWeather")
        )

        let data = try JSONEncoder().encode(request)
        let decoded = try JSONDecoder().decode(GPTFunctionCallRequest.self, from: data)
        XCTAssertEqual(decoded.model, "gpt-4.1")
        XCTAssertEqual(decoded.messages.first?.content, "What's the weather?")
        XCTAssertEqual(decoded.function_call, .named("getWeather"))
    }

    // MARK: - FunctionCallDirective

    func testFunctionCallDirectiveAutoEncodingDecoding() throws {
        let directive: FunctionCallDirective = .auto
        let data = try JSONEncoder().encode(directive)
        let decoded = try JSONDecoder().decode(FunctionCallDirective.self, from: data)
        XCTAssertEqual(decoded, .auto)
    }

    func testFunctionCallDirectiveNamedEncodingDecoding() throws {
        let directive: FunctionCallDirective = .named("lookup")
        let data = try JSONEncoder().encode(directive)
        let decoded = try JSONDecoder().decode(FunctionCallDirective.self, from: data)
        XCTAssertEqual(decoded, .named("lookup"))
    }

    func testFunctionCallDirectiveInvalidDecodingFails() {
        let json = #"{"unexpected":"value"}"#.data(using: .utf8)!
        XCTAssertThrowsError(try JSONDecoder().decode(FunctionCallDirective.self, from: json))
    }

    // MARK: - GPTCommand

    func testGPTCommandWithTarget() throws {
        let cmd = GPTCommand(action: "log", target: "exercise", parameters: ["reps": 10])
        let data = try JSONEncoder().encode(cmd)
        let decoded = try JSONDecoder().decode(GPTCommand.self, from: data)
        XCTAssertEqual(decoded.action, "log")
        XCTAssertEqual(decoded.target, "exercise")
        XCTAssertEqual(decoded.parameters["reps"], 10)
    }

    func testGPTCommandWithoutTarget() throws {
        let cmd = GPTCommand(action: "ping", target: nil, parameters: [:])
        let data = try JSONEncoder().encode(cmd)
        let decoded = try JSONDecoder().decode(GPTCommand.self, from: data)
        XCTAssertEqual(decoded.action, "ping")
        XCTAssertNil(decoded.target)
    }

    // MARK: - GPTResponse

    func testGPTResponseDecodingMinimal() throws {
        let json = """
        {
          "id": "abc123",
          "object": "chat.completion",
          "created": 1691234567,
          "model": "gpt-4.1",
          "choices": [{
            "index": 0,
            "message": {
              "role": "assistant",
              "content": "Hello"
            },
            "finish_reason": "stop"
          }]
        }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(GPTResponse.self, from: json)
        XCTAssertEqual(response.id, "abc123")
        XCTAssertEqual(response.choices.count, 1)
        XCTAssertEqual(response.choices.first?.message.content, "Hello")
    }

    func testGPTResponseWithFunctionCall() throws {
        let json = """
        {
          "id": "xyz789",
          "object": "chat.completion",
          "created": 1691234567,
          "model": "gpt-4.1",
          "choices": [{
            "index": 0,
            "message": {
              "role": "assistant",
              "content": null,
              "function_call": {
                "name": "lookup",
                "arguments": "{\\"id\\":42}"
              }
            },
            "finish_reason": "function_call"
          }]
        }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(GPTResponse.self, from: json)
        XCTAssertEqual(response.choices.first?.message.function_call?.name, "lookup")
        XCTAssertEqual(response.choices.first?.message.function_call?.arguments, "{\"id\":42}")
    }

    // MARK: - ValidationError

    func testValidationErrorEncodingDecoding() throws {
        let err = ValidationError(message: "Missing parameter", code: 422)
        let data = try JSONEncoder().encode(err)
        let decoded = try JSONDecoder().decode(ValidationError.self, from: data)
        XCTAssertEqual(decoded.message, "Missing parameter")
        XCTAssertEqual(decoded.code, 422)
    }

    func testValidationErrorWithNilCode() throws {
        let err = ValidationError(message: "Something went wrong", code: nil)
        let data = try JSONEncoder().encode(err)
        let decoded = try JSONDecoder().decode(ValidationError.self, from: data)
        XCTAssertEqual(decoded.message, "Something went wrong")
        XCTAssertNil(decoded.code)
    }
}
