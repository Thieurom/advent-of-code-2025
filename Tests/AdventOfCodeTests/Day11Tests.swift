@testable import aoc
import Testing

struct Day11Tests {

    @Test func testPart1() {
        let input = """
        aaa: you hhh
        you: bbb ccc
        bbb: ddd eee
        ccc: ddd eee fff
        ddd: ggg
        eee: out
        fff: out
        ggg: out
        hhh: ccc fff iii
        iii: out
        """

        let day = Day11(input: input)
        #expect(day.answerPart1() == 5)
    }

    @Test func testPart2() {
        let input = """
        svr: aaa bbb
        aaa: fft
        fft: ccc
        bbb: tty
        tty: ccc
        ccc: ddd eee
        ddd: hub
        hub: fff
        eee: dac
        dac: fff
        fff: ggg hhh
        ggg: out
        hhh: out
        """

        let day = Day11(input: input)
        #expect(day.answerPart2() == 2)
    }
}
