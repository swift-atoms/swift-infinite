import Affine
import Collection
import Iterator
import Tagged

extension Infinite.Cycle.Iterator: @unchecked Swift.Sendable where Base: Swift.Sendable, Base.Index: Swift.Sendable {}
