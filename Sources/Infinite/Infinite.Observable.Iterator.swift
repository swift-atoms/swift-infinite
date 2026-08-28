public import Iterator_Protocol

public struct __InfiniteObservableIterator<Source: Infinite.Observable>: ~Copyable,
    Iterator.Iterator.`Protocol`
where Source.Tail == Source {
    @usableFromInline
    var current: Source

    @inlinable
    package init(_ source: Source) {
        self.current = source
    }
}

extension __InfiniteObservableIterator {

    public typealias Element = Source.Element

    @inlinable
    public mutating func next() -> Source.Element? {
        let element = current.head
        current = current.tail
        return element
    }
}

extension __InfiniteObservableIterator: @unchecked Sendable where Source: Sendable {}

extension Infinite.Observable where Tail == Self {

    @inlinable
    public func makeIterator() -> __InfiniteObservableIterator<Self> {
        __InfiniteObservableIterator(self)
    }
}
