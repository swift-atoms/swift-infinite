import Testing

@testable import Infinite

@Suite
struct `Infinite repetition yields one unchanged value` {
    @Suite struct `Repeated values preserve constant traversal equality and hashing` {
        @Test
        func `init stores value`() {
            let repeat42 = Infinite.Repeat(42)
            #expect(repeat42.value == 42)
        }

        @Test
        func `head returns stored value`() {
            let repeat42 = Infinite.Repeat(42)
            #expect(repeat42.head == 42)
        }

        @Test
        func `tail returns self`() {
            let repeat42 = Infinite.Repeat(42)
            #expect(repeat42.tail.value == 42)
            #expect(repeat42.tail.tail.value == 42)
        }

        @Test
        func `iteration produces constant sequence`() {
            let ones = Infinite.Repeat(1)
            let first10 = Array(ones.prefix(10))
            #expect(first10 == [1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
        }

        @Test
        func `Infinite repetition preserves string and floating point values`() {
            let strings = Infinite.Repeat("hello")
            #expect(Array(strings.prefix(3)) == ["hello", "hello", "hello"])

            let doubles = Infinite.Repeat(3.14)
            #expect(Array(doubles.prefix(2)) == [3.14, 3.14])
        }

        @Test
        func `equal values are equal`() {
            let a = Infinite.Repeat(42)
            let b = Infinite.Repeat(42)
            #expect(a == b)
        }

        @Test
        func `different values are not equal`() {
            let a = Infinite.Repeat(42)
            let b = Infinite.Repeat(43)
            #expect(a != b)
        }

        @Test
        func `equal values have same hash`() {
            let a = Infinite.Repeat(42)
            let b = Infinite.Repeat(42)
            #expect(a.hashValue == b.hashValue)
        }

        @Test
        func `Sets deduplicate repetitions with equal stored values`() {
            let set: Set<Infinite.Repeat<Int>> = [
                Infinite.Repeat(1),
                Infinite.Repeat(2),
                Infinite.Repeat(1),
            ]
            #expect(set.count == 2)
        }
    }

    @Suite struct `No infinite repeat boundary cases are defined` {}
    @Suite struct `No infinite repeat integration cases are defined` {}
}
