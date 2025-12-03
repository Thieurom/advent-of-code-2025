@testable import aoc
import Testing

struct Day3Tests {

    let input = """
    987654321111111
    811111111111119
    234234234234278
    818181911112111
    """

    @Test func testPart1() {
        let day = Day3(input: input)
        #expect(day.answerPart1() == 357)
    }

    @Test func testPart2() {
        let day = Day3(input: input)
        #expect(day.answerPart2() == 3121910778619)
    }
}
