extension Infinite {

    public struct Iterate<Element> {

        @usableFromInline
        let initial: Element

        @usableFromInline
        let transform: @Sendable (Element) -> Element

        @inlinable
        public init(initial: Element, _ transform: @escaping @Sendable (Element) -> Element) {
            self.initial = initial
            self.transform = transform
        }
    }
}

extension Infinite.Iterate: Swift.Sendable where Element: Swift.Sendable {}

extension Infinite.Iterate: Infinite.Observable {

    @inlinable
    public var head: Element { initial }

    @inlinable
    public var tail: Self {
        Infinite.Iterate(initial: transform(initial), transform)
    }
}
