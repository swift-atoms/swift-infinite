import Testing

@testable import Infinite

@Suite
struct `Infinite cycles repeat the elements of a nonempty collection` {
    @Suite struct `Cycle heads tails and iterators preserve the repeating collection` {
        @Test
        func `Infinite cycles repeat array elements in their original order`() {
            let colors = Infinite.Cycle(["red", "green", "blue"])!
            let first10 = Array(colors.prefix(10))
            #expect(
                first10 == [
                    "red", "green", "blue", "red", "green", "blue", "red", "green", "blue", "red",
                ]
            )
        }

        @Test
        func `A single element cycle repeats that element`() {
            let ones = Infinite.Cycle([1])!
            let first5 = Array(ones.prefix(5))
            #expect(first5 == [1, 1, 1, 1, 1])
        }

        @Test
        func `Unchecked cycle construction preserves a nonempty collection`() {
            let cycle = Infinite.Cycle(__unchecked: (), [1, 2, 3])
            #expect(Array(cycle.prefix(6)) == [1, 2, 3, 1, 2, 3])
        }

        @Test
        func `Infinite cycles repeat the characters of a string`() {

            let chars = Infinite.Cycle("abc")!
            let first6 = Array(chars.prefix(6))
            #expect(first6 == ["a", "b", "c", "a", "b", "c"])
        }

        @Test
        func `head returns first element`() {
            let cycle = Infinite.Cycle([1, 2, 3])!
            #expect(cycle.head == 1)
        }

        @Test
        func `tail head returns second element`() {
            let cycle = Infinite.Cycle([1, 2, 3])!
            #expect(cycle.tail.head == 2)
        }

        @Test
        func `tail wraps around`() {
            let cycle = Infinite.Cycle([1, 2, 3])!
            #expect(cycle.tail.tail.tail.head == 1)
        }

        @Test
        func `Cycle heads and iteration start from the first element`() {
            let cycle = Infinite.Cycle([1, 2, 3])!

            #expect(cycle.head == 1)

            let iteratedValues = Array(cycle.prefix(6))
            #expect(iteratedValues == [1, 2, 3, 1, 2, 3])
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

    @Suite struct `Infinite cycle construction rejects an empty collection` {
        @Test
        func `init returns nil for empty collection`() {
            let empty: Infinite.Cycle<[Int]>? = Infinite.Cycle([])
            #expect(empty == nil)
        }
    }

    @Suite struct `No infinite cycle integration cases are defined` {}
}
