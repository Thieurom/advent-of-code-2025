@testable import aoc
import Testing

struct Day6Tests {

    let input = """
    123 328  51 64 
     45 64  387 23 
      6 98  215 314
    *   +   *   +  
    """

    @Test func testPart1() {
        let day = Day6(input: input)
        #expect(day.answerPart1() == 4277556)
    }

    @Test func testPart2() {
        let day = Day6(input: input)
        #expect(day.answerPart2() == 3263827)
    }
}
