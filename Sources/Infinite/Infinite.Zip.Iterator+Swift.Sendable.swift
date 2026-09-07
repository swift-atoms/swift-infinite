import Iterator

extension Infinite.Zip.Iterator: @unchecked Swift.Sendable
where First.Iterator: Swift.Sendable, Second.Iterator: Swift.Sendable {}
