extension Infinite {

    public struct Repeat<Element> {

        public let value: Element

        @inlinable
        public init(_ value: Element) {
            self.value = value
        }
    }
}

extension Infinite.Repeat: Swift.Sendable where Element: Swift.Sendable {}

extension Infinite.Repeat: Infinite.Observable {

    @inlinable
    public var head: Element { value }

    @inlinable
    public var tail: Self { self }
}
