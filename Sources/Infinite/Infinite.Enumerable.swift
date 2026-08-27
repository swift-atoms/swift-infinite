public import Iterator

extension Infinite {

    public typealias IteratorProtocol = Iterator.`Protocol`

    public protocol Enumerable {
        associatedtype Element
        associatedtype Iterator: ~Copyable, Infinite.IteratorProtocol
        where Iterator.Element == Element, Iterator.Failure == Never
        func makeIterator() -> Iterator
    }
}

extension Infinite.Enumerable where Element: Copyable {

    @inlinable
    public func prefix(_ maxLength: Int) -> [Element] {
        var iter = makeIterator()
        var result: [Element] = []
        result.reserveCapacity(maxLength)
        for _ in 0..<maxLength {
            guard let element = iter.next() else { break }
            result.append(element)
        }
        return result
    }
}
