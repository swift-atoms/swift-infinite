import Iterator_Protocol

extension Infinite {

    public struct Zip<First: Infinite.Enumerable, Second: Infinite.Enumerable> {

        @usableFromInline
        let first: First

        @usableFromInline
        let second: Second

        @inlinable
        public init(_ first: First, _ second: Second) {
            self.first = first
            self.second = second
        }
    }
}

extension Infinite {

    @inlinable
    public static func zip<First: Enumerable, Second: Enumerable>(
        _ first: First,
        _ second: Second
    ) -> Self.Zip<First, Second> {
        Self.Zip(first, second)
    }
}

extension Infinite.Zip {

    @inlinable
    public func makeIterator() -> Iterator {
        Iterator(first: first.makeIterator(), second: second.makeIterator())
    }

}

extension Infinite.Zip: Sendable where First: Sendable, Second: Sendable {}

extension Infinite.Zip.Iterator: @unchecked Sendable
where First.Iterator: Sendable, Second.Iterator: Sendable {}

extension Infinite.Zip: Infinite.Enumerable {}

extension Infinite.Zip: Infinite.Observable
where First: Infinite.Observable, Second: Infinite.Observable {

    @inlinable
    public var head: (First.Element, Second.Element) {
        (first.head, second.head)
    }

    @inlinable
    public var tail: Infinite.Zip<First.Tail, Second.Tail> {
        Infinite.Zip<First.Tail, Second.Tail>(first.tail, second.tail)
    }
}
