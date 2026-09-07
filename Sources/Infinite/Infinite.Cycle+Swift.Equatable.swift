public import Affine
public import Collection
import Iterator
public import Tagged

extension Infinite.Cycle: Swift.Equatable where Base: Swift.Equatable {

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.base == rhs.base
    }
}
