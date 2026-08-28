public import Iterator_Protocol

extension Infinite.Cycle {

    public struct Iterator: ~Copyable, Iterator.Iterator.`Protocol` {
        @usableFromInline
        let base: Base

        @usableFromInline
        var index: Base.Index

        @inlinable
        package init(base: Base) {
            self.base = base
            self.index = base.startIndex
        }
    }
}

extension Infinite.Cycle.Iterator {

    public typealias Element = Base.Element

    @inlinable
    public mutating func next() -> Base.Element? {
        let element = base[index]
        base.formIndex(after: &index)
        if index == base.endIndex {
            index = base.startIndex
        }
        return element
    }
}
