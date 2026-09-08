import Collection
import Iterator
import Tagged

extension Infinite.Cycle: Swift.Equatable where Base: Swift.Equatable {

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.base == rhs.base
    }
}
