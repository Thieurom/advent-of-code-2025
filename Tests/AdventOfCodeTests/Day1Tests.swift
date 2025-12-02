@testable import aoc
import Testing

struct Day1Tests {

    let input = """
    L68
    L30
    R48
    L5
    R60
    L55
    L1
    L99
    R14
    L82
    """

    @Test func testPart1() {
        let day = Day1(input: input)
        #expect(day.answerPart1() == 3)
    }

    @Test func testPart2() {
        let day = Day1(input: input)
        #expect(day.answerPart2() == 6)
    }
}
