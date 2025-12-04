@testable import aoc
import Testing

struct Day4Tests {

    let input = """
    ..@@.@@@@.
    @@@.@.@.@@
    @@@@@.@.@@
    @.@@@@..@.
    @@.@@@@.@@
    .@@@@@@@.@
    .@.@.@.@@@
    @.@@@.@@@@
    .@@@@@@@@.
    @.@.@@@.@.
    """

    @Test func testPart1() {
        let day = Day4(input: input)
        #expect(day.answerPart1() == 13)
    }

    @Test func testPart2() {
        let day = Day4(input: input)
        #expect(day.answerPart2() == 43)
    }
}
