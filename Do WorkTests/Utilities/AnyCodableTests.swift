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
}