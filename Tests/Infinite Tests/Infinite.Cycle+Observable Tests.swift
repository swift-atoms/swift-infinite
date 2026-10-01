import Infinite
import Testing


@Suite
struct `Infinite Cycle Observable Tests` {
    @Suite struct Unit {
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
        func `head/tail matches iteration for first few elements`() {
            let cycle = Infinite.Cycle([1, 2, 3])!

            #expect(cycle.head == 1)

            let iteratedValues = Array(cycle.prefix(6))
            #expect(iteratedValues == [1, 2, 3, 1, 2, 3])
        }
    }
}
