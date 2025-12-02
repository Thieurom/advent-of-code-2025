//
//  ExampleDayTests.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 4/12/24.
//

@testable import aoc
import Testing

struct ExampleDayTests {

    @Test func testPart1WithInput1() {
        let day = ExampleDay(input: "1 2 3")
        #expect(day.answerPart1() == 6)
    }

    @Test func testPart1WithInput2() {
        let day = ExampleDay(input: "1 2 3 4 5")
        #expect(day.answerPart1() == 15)
    }

    @Test func testPart2WithInput1() {
        let day = ExampleDay(input: "1 2 3")
        #expect(day.answerPart2() == 6)
    }

    @Test func testPart2WithInput2() {
        let day = ExampleDay(input: "1 2 3 4 5")
        #expect(day.answerPart2() == 120)
    }
}
