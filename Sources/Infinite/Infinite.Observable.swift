extension Infinite {

    public protocol Observable: Enumerable {

        associatedtype Tail: Observable where Tail.Element == Element

        var head: Element { get }

        var tail: Tail { get }
    }
}
