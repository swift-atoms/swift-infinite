// Infinite.Zip.Iterator.swift
// The iterator backing Infinite.Zip.

public import Iterator_Protocol

extension Infinite.Zip {
    /// An iterator that pairs elements from two sources.
    ///
    /// Uses `Optional<(First.Element, Second.Element)>` as inline storage for
    /// span-based access. Zero heap allocation. The Optional payload is at byte
    /// offset 0 (ABI guarantee for single-payload enums), enabling safe
    /// reinterpretation as a `Span` via `withUnsafeMutablePointer`.
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
    /// The element type: a pair of one element drawn from each source sequence.
    public typealias Element = (First.Element, Second.Element)

    /// Returns the next pair of elements.
    @inlinable
    public mutating func next() -> (First.Element, Second.Element)? {
        guard let a = first.next(), let b = second.next() else { return nil }
        return (a, b)
    }
}
