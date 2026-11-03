# swift-infinite

Use this package when you need a sequence that never ends: a constant (`Infinite.Repeat`), a nonempty collection repeated forever (`Infinite.Cycle`), a value under repeated transformation (`Infinite.Iterate`), elements produced from evolving state (`Infinite.Unfold`), or a mapping, positional pairing or running accumulation of such a sequence (`Infinite.Map`, `Infinite.Zip`, `Infinite.Scan`). Start from `Infinite.Enumerable` to consume one by iteration, and from `Infinite.Observable` to take it apart as a first element and the rest. A sequence that can end does not belong here.

## Laws

- An iterator of an `Infinite.Enumerable` never returns `nil`, so `prefix(_:)` always returns exactly the requested number of elements.
- A value describes its sequence; it is not a stream. Every `makeIterator()` starts again from the first element, and nothing is cached: `head` and `tail` recompute on every access. `Infinite.Unfold` calls its step once for `head` and again for `tail`, and `Infinite.Map` applies its transform on every `head`. The closures must therefore be pure.
- For every `Infinite.Observable`, iteration yields `head`, then `tail.head`, then `tail.tail.head`, and so on.
- `Infinite.Cycle` yields the base collection's elements in order and wraps to the first after the last. Its `tail` rotates the base by one position, so after as many tails as the base has elements, `head` is the first element again. `init(__unchecked:_:)` skips the nonempty check that the failable initializer makes; an empty base traps on the first element.
- `Infinite.Cycle` equality and hashing compare the base collection, not a position in it. `Infinite.Repeat` equality and hashing compare the repeated value.
- `Infinite.Scan` yields the initial accumulator first, before it consumes any source element; its element at position k is the accumulator combined with the first k source elements in order.
- `Infinite.Zip` pairs the elements at the same position of both sources.
