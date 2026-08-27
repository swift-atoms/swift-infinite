import Testing

@testable import Infinite

@Suite
struct `Infinite Cycle Tests` {
    @Suite struct Unit {
        @Test
        func `cycles through array`() {
            let colors = Infinite.Cycle(["red", "green", "blue"])!
            let first10 = Array(colors.prefix(10))
            #expect(
                first10 == [
                    "red", "green", "blue", "red", "green", "blue", "red", "green", "blue", "red",
                ]
            )
        }

        @Test
        func `cycles through single element`() {
            let ones = Infinite.Cycle([1])!
            let first5 = Array(ones.prefix(5))
            #expect(first5 == [1, 1, 1, 1, 1])
        }

        @Test
        func `unchecked init works for non-empty`() {
            let cycle = Infinite.Cycle(__unchecked: (), [1, 2, 3])
            #expect(Array(cycle.prefix(6)) == [1, 2, 3, 1, 2, 3])
        }

        @Test
        func `works with different collection types`() {

            let chars = Infinite.Cycle("abc")!
            let first6 = Array(chars.prefix(6))
            #expect(first6 == ["a", "b", "c", "a", "b", "c"])
        }

        @Test
        func `equal bases are equal`() {
            let a = Infinite.Cycle([1, 2, 3])!
            let b = Infinite.Cycle([1, 2, 3])!
            #expect(a == b)
        }

        @Test
        func `different bases are not equal`() {
            let a = Infinite.Cycle([1, 2, 3])!
            let b = Infinite.Cycle([1, 2, 4])!
            #expect(a != b)
        }
    }

    @Suite struct `Edge Case` {
        @Test
        func `init returns nil for empty collection`() {
            let empty: Infinite.Cycle<[Int]>? = Infinite.Cycle([])
            #expect(empty == nil)
        }
    }

    @Suite struct Integration {}
}
