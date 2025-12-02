//
//  DailySolvable.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 4/12/24.
//

import Foundation

protocol DailySolvable: Sendable {

    static var day: Int { get }

    init(input: String)
    func answerPart1() -> Int
    func answerPart2() -> Int
}

extension DailySolvable {

    static private func loadInputFromFile(day: Int) -> String {
        let dayString = String(format: "%02d", day)
        let fileName = "Day\(dayString)"
        let url = Bundle.module.url(
            forResource: fileName,
            withExtension: "txt"
        )

        guard let url, let data = try? String(contentsOf: url, encoding: .utf8) else {
            print("Couldn't load data for \(fileName).txt")
            return ""
        }
        return data
    }

    init() {
        self.init(input: Self.loadInputFromFile(day: Self.day))
    }

    var day: Int {
        Self.day
    }

    var name: String {
        "Day \(day)"
    }
}
