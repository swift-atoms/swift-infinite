public import Iterator_Protocol

extension Infinite.Zip {

    public struct Iterator: ~Copyable, Iterator_Primitive.Iterator.`Protocol` {
        @usableFromInline
        var first: First.Iterator

        @usableFromInline
        var second: Second.Iterator

        @inlinable
        package init(first: consuming First.Iterator, second: consuming Second.Iterator) {
            self.first = first
            self.second = second
        }
    }
}

extension Infinite.Zip.Iterator {

    public typealias Element = (First.Element, Second.Element)

    @inlinable
    public mutating func next() -> (First.Element, Second.Element)? {
        guard let a = first.next(), let b = second.next() else { return nil }
        return (a, b)
    }
}
