extension Infinite {

    public struct Unfold<State, Element> {

        @usableFromInline
        let seed: State

        @usableFromInline
        let step: @Sendable (State) -> (Element, State)

        @inlinable
        public init(seed: State, step: @escaping @Sendable (State) -> (Element, State)) {
            self.seed = seed
            self.step = step
        }
    }
}

extension Infinite.Unfold: Sendable where State: Sendable {}

extension Infinite.Unfold: Infinite.Observable {

    @inlinable
    public var head: Element {
        step(seed).0
    }

    @inlinable
    public var tail: Self {
        Infinite.Unfold(seed: step(seed).1, step: step)
    }
}
