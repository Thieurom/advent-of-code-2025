@testable import aoc
import Testing

struct Day9Tests {

    let input = """
    7,1
    11,1
    11,7
    9,7
    9,5
    2,5
    2,3
    7,3
    """

    @Test func testPart1() {
        let day = Day9(input: input)
        #expect(day.answerPart1() == 50)
    }

    @Test func testPart2() {
        let day = Day9(input: input)
        #expect(day.answerPart2() == 24)
    }
}
