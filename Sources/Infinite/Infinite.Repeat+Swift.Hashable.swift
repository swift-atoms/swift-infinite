extension Infinite.Repeat: Swift.Hashable where Element: Swift.Hashable {

    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}
