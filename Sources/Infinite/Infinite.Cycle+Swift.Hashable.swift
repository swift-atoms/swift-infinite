public import Affine
public import Collection
import Iterator
public import Tagged

extension Infinite.Cycle: Swift.Hashable where Base: Swift.Hashable {

    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(base)
    }
}
