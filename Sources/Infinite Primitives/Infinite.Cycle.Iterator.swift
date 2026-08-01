// Infinite.Cycle.Iterator.swift
// The iterator backing Infinite.Cycle.

public import Iterator_Protocol

extension Infinite.Cycle {
    /// An iterator that cycles through a collection indefinitely.
    ///
    /// Uses `Optional<Base.Element>` as inline storage for span-based access.
    /// Zero heap allocation. The Optional payload is at byte offset 0
    /// (ABI guarantee for single-payload enums), enabling safe reinterpretation
    /// as a `Span<Base.Element>` via `withUnsafeMutablePointer`.
    public struct Iterator: ~Copyable, Iterator_Primitive.Iterator.`Protocol` {
        @usableFromInline
        let base: Base

        @usableFromInline
        var index: Base.Index

        @inlinable
        package init(base: Base) {
            self.base = base
            self.index = base.startIndex
        }
    }
}

extension Infinite.Cycle.Iterator {
    /// The element type: the base collection's element.
    public typealias Element = Base.Element

    /// Returns the next element, wrapping to the start when exhausted.
    @inlinable
    public mutating func next() -> Base.Element? {
        let element = base[index]
        base.formIndex(after: &index)
        if index == base.endIndex {
            index = base.startIndex
        }
        return element
    }
}
