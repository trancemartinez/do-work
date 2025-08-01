import Foundation

/**
 A type-erased `Codable` value that forwards encoding and decoding
 to an underlying value of any supported type.

 Supports JSON-compatible types: `Bool`, numbers, `String`,
 dictionaries, arrays, and `nil` (represented as `Void`).

 Use `AnyCodable` to encode/decode heterogeneous or dynamic JSON
 structures where types are unknown at compile time.
 */
@frozen public struct AnyCodable: Codable {
    public let value: Any

    public init<T>(_ value: T?) {
        self.value = value ?? ()
    }
}

// MARK: - Encoding & Decoding (delegated to internal protocols)
extension AnyCodable: _AnyEncodable, _AnyDecodable {}

// MARK: - Equatable
extension AnyCodable: Equatable {
    public static func == (lhs: AnyCodable, rhs: AnyCodable) -> Bool {
        switch (lhs.value, rhs.value) {
        case (is Void, is Void): return true
        case let (l as Bool, r as Bool): return l == r
        case let (l as Int, r as Int): return l == r
        case let (l as Int8, r as Int8): return l == r
        case let (l as Int16, r as Int16): return l == r
        case let (l as Int32, r as Int32): return l == r
        case let (l as Int64, r as Int64): return l == r
        case let (l as UInt, r as UInt): return l == r
        case let (l as UInt8, r as UInt8): return l == r
        case let (l as UInt16, r as UInt16): return l == r
        case let (l as UInt32, r as UInt32): return l == r
        case let (l as UInt64, r as UInt64): return l == r
        case let (l as Float, r as Float): return l == r
        case let (l as Double, r as Double): return l == r
        case let (l as String, r as String): return l == r
        case let (l as [String: AnyCodable], r as [String: AnyCodable]): return l == r
        case let (l as [AnyCodable], r as [AnyCodable]): return l == r
        case let (l as [String: Any], r as [String: Any]):
            return NSDictionary(dictionary: l).isEqual(to: r)
        case let (l as [Any], r as [Any]):
            return NSArray(array: l).isEqual(to: r)
        case (is NSNull, is NSNull): return true
        default: return false
        }
    }
}

// MARK: - CustomStringConvertible & Debug
extension AnyCodable: CustomStringConvertible {
    public var description: String {
        switch value {
        case is Void: return "nil"
        case let value as CustomStringConvertible: return value.description
        default: return String(describing: value)
        }
    }
}

extension AnyCodable: CustomDebugStringConvertible {
    public var debugDescription: String {
        if let debugValue = value as? CustomDebugStringConvertible {
            return "AnyCodable(\(debugValue.debugDescription))"
        }
        return "AnyCodable(\(description))"
    }
}

// MARK: - ExpressibleBy*Literal for easier usage
extension AnyCodable: ExpressibleByNilLiteral,
                      ExpressibleByBooleanLiteral,
                      ExpressibleByIntegerLiteral,
                      ExpressibleByFloatLiteral,
                      ExpressibleByStringLiteral,
                      ExpressibleByStringInterpolation,
                      ExpressibleByArrayLiteral,
                      ExpressibleByDictionaryLiteral {

    public init(nilLiteral: ()) {
        self.init(())
    }

    public init(booleanLiteral value: Bool) {
        self.init(value)
    }

    public init(integerLiteral value: Int) {
        self.init(value)
    }

    public init(floatLiteral value: Double) {
        self.init(value)
    }

    public init(stringLiteral value: String) {
        self.init(value)
    }

    public init(stringInterpolation: String.StringInterpolation) {
        self.init(stringInterpolation.description)
    }

    public init(arrayLiteral elements: AnyCodable...) {
        self.init(elements)
    }

    public init(dictionaryLiteral elements: (String, AnyCodable)...) {
        self.init(Dictionary(uniqueKeysWithValues: elements))
    }
}

// MARK: - Hashable
extension AnyCodable: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch value {
        case let v as Bool: hasher.combine(v)
        case let v as Int: hasher.combine(v)
        case let v as Int8: hasher.combine(v)
        case let v as Int16: hasher.combine(v)
        case let v as Int32: hasher.combine(v)
        case let v as Int64: hasher.combine(v)
        case let v as UInt: hasher.combine(v)
        case let v as UInt8: hasher.combine(v)
        case let v as UInt16: hasher.combine(v)
        case let v as UInt32: hasher.combine(v)
        case let v as UInt64: hasher.combine(v)
        case let v as Float: hasher.combine(v)
        case let v as Double: hasher.combine(v)
        case let v as String: hasher.combine(v)
        case let v as [String: AnyCodable]: hasher.combine(v)
        case let v as [AnyCodable]: hasher.combine(v)
        default: break
        }
    }
}