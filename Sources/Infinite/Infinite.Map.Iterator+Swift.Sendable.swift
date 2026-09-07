import Iterator

extension Infinite.Map.Iterator: @unchecked Swift.Sendable where Source.Iterator: Swift.Sendable {}
