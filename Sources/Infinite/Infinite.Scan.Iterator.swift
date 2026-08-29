public import Iterator_Protocol

extension Infinite.Scan {

    public struct Iterator: ~Copyable, Iterator::Iterator.`Protocol` {
        @usableFromInline
        var accumulator: Result

        @usableFromInline
        var source: Source.Iterator

        @usableFromInline
        let combine: @Sendable (Result, Source.Element) -> Result

        @usableFromInline
        var emittedInitial: Bool = false

        @inlinable
        package init(
            accumulator: Result,
            source: consuming Source.Iterator,
            combine: @escaping @Sendable (Result, Source.Element) -> Result
        ) {
            self.accumulator = accumulator
            self.source = source
            self.combine = combine
        }
    }
}

extension Infinite.Scan.Iterator {

    public typealias Element = Result

    @inlinable
    public mutating func next() -> Result? {
        if !emittedInitial {
            emittedInitial = true
            return accumulator
        }
        guard let element = source.next() else { return nil }
        accumulator = combine(accumulator, element)
        return accumulator
    }
}
