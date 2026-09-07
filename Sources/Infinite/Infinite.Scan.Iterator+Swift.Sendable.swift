import Iterator

extension Infinite.Scan.Iterator: @unchecked Swift.Sendable
where Source.Iterator: Swift.Sendable, Result: Swift.Sendable {}
