// Infinite.Scan.Iterator.swift
// The iterator backing Infinite.Scan.

public import Iterator_Protocol

extension Infinite.Scan {
    /// An iterator that produces running accumulations.
    ///
    /// Uses `Optional<Result>` as inline storage for span-based access.
    /// Zero heap allocation. The Optional payload is at byte offset 0
    /// (ABI guarantee for single-payload enums), enabling safe reinterpretation
    /// as a `Span<Result>` via `withUnsafeMutablePointer`.
    public struct Iterator: ~Copyable, Iterator_Primitive.Iterator.`Protocol` {
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
    /// The element type: the running accumulator's result type.
    public typealias Element = Result

    /// Returns the next accumulator value.
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
