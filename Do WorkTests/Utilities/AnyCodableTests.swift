//
//  AnyCodableTests.swift
//  Do Work
//
//  Created by Chance Martinez on 7/31/25.
//

@testable import Do_Work
import XCTest

final class AnyCodableTests: XCTestCase {
    
    func testEncodeDecode_Int() throws {
        let original = AnyCodable(42)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        XCTAssertEqual(original, decoded)
    }
    
    func testEncodeDecode_String() throws {
        let original = AnyCodable("Hello, world!")
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        XCTAssertEqual(original, decoded)
    }
    
    func testEncodeDecode_Bool() throws {
        let original = AnyCodable(true)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        XCTAssertEqual(original, decoded)
    }
    
    func testEncodeDecode_Array() throws {
        let original = AnyCodable([1, 2, 3])
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        XCTAssertEqual(original, decoded)
    }
    
    func testEncodeDecode_Dictionary() throws {
        let original = AnyCodable(["key": "value", "number": 10])
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        XCTAssertEqual(original, decoded)
    }
    
    func testEncodeDecode_Nil() throws {
        let original: AnyCodable = nil
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        XCTAssertEqual(original, decoded)
    }
    
    func testUnsupportedType_Throws() {
        struct Uncodable {}
        let value = AnyCodable(Uncodable())
        
        XCTAssertThrowsError(try JSONEncoder().encode(value))
    }
    func testEncodeDecode_Double() throws {
        let original = AnyCodable(3.14159)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        XCTAssertEqual(original, decoded)
    }

    func testEncodeDecode_NestedDictionary() throws {
        let original = AnyCodable(["outer": ["inner": 1]])
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        XCTAssertEqual(original, decoded)
    }

    func testEncodeDecode_NestedArray() throws {
        let original = AnyCodable([[1, 2], [3, 4]])
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        XCTAssertEqual(original, decoded)
    }

    func testEncodeDecode_EmptyArray() throws {
        let original = AnyCodable([AnyCodable]())
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        XCTAssertEqual(original, decoded)
    }

    func testEncodeDecode_EmptyDictionary() throws {
        let original = AnyCodable([String: AnyCodable]())
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        XCTAssertEqual(original, decoded)
    }

    func testEncodeDecode_NSNull() throws {
        let original = AnyCodable(nil)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        XCTAssertEqual(original, decoded)
    }
}
