public import Iterator_Protocol

extension Infinite {

    public protocol Enumerable {
        associatedtype Element
        associatedtype Iterator: ~Copyable, Iterator.Iterator.`Protocol`
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
