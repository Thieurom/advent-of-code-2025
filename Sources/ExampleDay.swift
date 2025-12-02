//
//  ExampleDay.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 5/12/24.
//

struct ExampleDay: DailySolvable {

    static let day = 0
    let input: [Int]

    init(input: String) {
        self.input = input
            .split(separator: " ")
            .compactMap { Int($0) }
    }

    func answerPart1() -> Int {
        input.reduce(0, +)
    }

    func answerPart2() -> Int {
        input.reduce(1, *)
    }
}
