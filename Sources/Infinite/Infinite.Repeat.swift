extension Infinite {

    public struct Repeat<Element> {

        public let value: Element

        @inlinable
        public init(_ value: Element) {
            self.value = value
        }
    }
}

extension Infinite.Repeat: Swift::Sendable where Element: Swift::Sendable {}

extension Infinite.Repeat: Infinite.Observable {

    @inlinable
    public var head: Element { value }

    @inlinable
    public var tail: Self { self }
}

extension Infinite.Repeat: Swift::Equatable where Element: Swift::Equatable {

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.value == rhs.value
    }
}

extension Infinite.Repeat: Swift::Hashable where Element: Swift::Hashable {

    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}
