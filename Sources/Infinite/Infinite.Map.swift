import Iterator_Protocol

extension Infinite {

    public struct Map<Source: Infinite.Enumerable, Element> {

        @usableFromInline
        let source: Source

        @usableFromInline
        let transform: @Sendable (Source.Element) -> Element

        @inlinable
        public init(_ source: Source, _ transform: @escaping @Sendable (Source.Element) -> Element)
        {
            self.source = source
            self.transform = transform
        }
    }
}

extension Infinite.Map {

    @inlinable
    public func makeIterator() -> Iterator {
        Iterator(base: source.makeIterator(), transform: transform)
    }

}

extension Infinite.Map: Sendable where Source: Sendable {}

extension Infinite.Map.Iterator: @unchecked Sendable where Source.Iterator: Sendable {}

extension Infinite.Map: Infinite.Enumerable {}

extension Infinite.Map: Infinite.Observable
where Source: Infinite.Observable {

    @inlinable
    public var head: Element {
        transform(source.head)
    }

    @inlinable
    public var tail: Infinite.Map<Source.Tail, Element> {
        Infinite.Map<Source.Tail, Element>(source.tail, transform)
    }
}

extension Infinite.Enumerable {

    @inlinable
    public func map<T>(_ transform: @escaping @Sendable (Element) -> T) -> Infinite.Map<Self, T> {
        Infinite.Map(self, transform)
    }
}
