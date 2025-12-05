@testable import aoc
import Testing

struct Day5Tests {

    let input = """
    3-5
    10-14
    16-20
    12-18

    1
    5
    8
    11
    17
    32
    """

    @Test func testPart1() {
        let day = Day5(input: input)
        #expect(day.answerPart1() == 3)
    }

    @Test func testPart2() {
        let day = Day5(input: input)
        #expect(day.answerPart2() == 14)
    }
}
