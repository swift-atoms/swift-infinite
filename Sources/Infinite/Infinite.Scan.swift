import Iterator

extension Infinite {

    public struct Scan<Source: Infinite.Enumerable, Result> {

        @usableFromInline
        let initial: Result

        @usableFromInline
        let source: Source

        @usableFromInline
        let combine: @Sendable (Result, Source.Element) -> Result

        @inlinable
        public init(
            initial: Result,
            source: Source,
            _ combine: @escaping @Sendable (Result, Source.Element) -> Result
        ) {
            self.initial = initial
            self.source = source
            self.combine = combine
        }
    }
}

extension Infinite.Scan {

    @inlinable
    public func makeIterator() -> Iterator {
        Iterator(accumulator: initial, source: source.makeIterator(), combine: combine)
    }

}

extension Infinite.Scan: Sendable where Source: Sendable, Result: Sendable {}

extension Infinite.Scan.Iterator: @unchecked Sendable
where Source.Iterator: Sendable, Result: Sendable {}

extension Infinite.Scan: Infinite.Enumerable {}

extension Infinite.Enumerable {

    @inlinable
    public func scan<T>(
        initial: T,
        _ combine: @escaping @Sendable (T, Element) -> T
    ) -> Infinite.Scan<Self, T> {
        Infinite.Scan(initial: initial, source: self, combine)
    }
}
