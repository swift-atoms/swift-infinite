// Infinite.Map.Iterator.swift
// The iterator backing Infinite.Map.

public import Iterator_Protocol

extension Infinite.Map {
    /// An iterator that applies a transformation to each element.
    ///
    /// Uses `Optional<Element>` as inline storage for span-based access.
    /// Zero heap allocation. The Optional payload is at byte offset 0
    /// (ABI guarantee for single-payload enums), enabling safe reinterpretation
    /// as a `Span<Element>` via `withUnsafeMutablePointer`.
    public struct Iterator: ~Copyable, Iterator_Primitive.Iterator.`Protocol` {
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
    /// Returns the transformed next element.
    @inlinable
    public mutating func next() -> Element? {
        base.next().map(transform)
    }
}
