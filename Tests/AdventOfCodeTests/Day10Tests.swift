@testable import aoc
import Testing

struct Day10Tests {

    let input = """
    [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
    [...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
    [.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
    """

    @Test func testPart1() {
        let day = Day10(input: input)
        #expect(day.answerPart1() == 7)
    }

    @Test func testPart2() {
        let day = Day10(input: input)
        #expect(day.answerPart2() == 0)
    }
}
