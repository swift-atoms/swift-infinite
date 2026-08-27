import Iterator

extension Infinite {

    public struct Cycle<Base: Swift.Collection> {

        @usableFromInline
        let base: Base

        @inlinable
        public init?(_ base: Base) {
            guard !base.isEmpty else { return nil }
            self.base = base
        }

        @inlinable
        public init(__unchecked: Void, _ base: Base) {
            self.base = base
        }
    }
}

extension Infinite.Cycle {

    @inlinable
    public func makeIterator() -> Iterator {
        Iterator(base: base)
    }
}

extension Infinite.Cycle: Sendable where Base: Sendable {}

extension Infinite.Cycle.Iterator: @unchecked Sendable where Base: Sendable, Base.Index: Sendable {}

extension Infinite.Cycle: Infinite.Enumerable {}

extension Infinite.Cycle: Equatable where Base: Equatable {

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.base == rhs.base
    }
}

extension Infinite.Cycle: Hashable where Base: Hashable {

    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(base)
    }
}
