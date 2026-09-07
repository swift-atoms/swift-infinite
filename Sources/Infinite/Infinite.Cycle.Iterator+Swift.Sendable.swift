public import Affine
public import Collection
import Iterator
public import Tagged

extension Infinite.Cycle.Iterator: @unchecked Swift.Sendable where Base: Swift.Sendable, Base.Index: Swift.Sendable {}
