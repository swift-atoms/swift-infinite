public import Iterator_Protocol

extension Infinite.Map {

    public struct Iterator: ~Copyable, Iterator::Iterator.`Protocol` {
        @usableFromInline
        var base: Source.Iterator

        @usableFromInline
        let transform: @Sendable (Source.Element) -> Element

        @inlinable
        package init(
            base: consuming Source.Iterator,
            transform: @escaping @Sendable (Source.Element) -> Element
        ) {
            self.base = base
            self.transform = transform
        }
    }
}

extension Infinite.Map.Iterator {

    @inlinable
    public mutating func next() -> Element? {
        base.next().map(transform)
    }
}
