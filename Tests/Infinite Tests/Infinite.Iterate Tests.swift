import Testing

@testable import Infinite

@Suite
struct `Infinite iteration repeatedly applies a state transformation` {
    @Suite struct `Iterated heads tails and iterators follow repeated transformation` {
        @Test
        func `Repeated incrementing generates the natural numbers`() {
            let naturals = Infinite.Iterate(initial: 0) { $0 + 1 }
            let first10 = Array(naturals.prefix(10))
            #expect(first10 == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        }

        @Test
        func `Repeated doubling generates successive powers of two`() {
            let powers = Infinite.Iterate(initial: 1) { $0 * 2 }
            let first10 = Array(powers.prefix(10))
            #expect(first10 == [1, 2, 4, 8, 16, 32, 64, 128, 256, 512])
        }

        @Test
        func `head returns initial value`() {
            let naturals = Infinite.Iterate(initial: 0) { $0 + 1 }
            #expect(naturals.head == 0)
        }

        @Test
        func `tail advances by one application`() {
            let naturals = Infinite.Iterate(initial: 0) { $0 + 1 }
            #expect(naturals.tail.head == 1)
            #expect(naturals.tail.tail.head == 2)
        }

        @Test
        func `Head and tail traversal follows the generated sequence`() {
            let naturals = Infinite.Iterate(initial: 0) { $0 + 1 }

            var current = naturals
            var headValues: [Int] = []
            for _ in 0..<5 {
                headValues.append(current.head)
                current = current.tail
            }

            #expect(headValues == [0, 1, 2, 3, 4])
        }

        @Test
        func `Infinite iteration follows conditional state transformations`() {

            let seq = Infinite.Iterate(initial: 10) { n in
                n % 2 == 0 ? n / 2 : 3 * n + 1
            }
            let first10 = Array(seq.prefix(10))
            #expect(first10 == [10, 5, 16, 8, 4, 2, 1, 4, 2, 1])
        }

        @Test
        func `Infinite iteration supports successive string transformations`() {
            let strings = Infinite.Iterate(initial: "a") { $0 + "a" }
            let first5 = Array(strings.prefix(5))
            #expect(first5 == ["a", "aa", "aaa", "aaaa", "aaaaa"])
        }
    }

    @Suite struct `No infinite iterate boundary cases are defined` {}
    @Suite struct `No infinite iterate integration cases are defined` {}
}
