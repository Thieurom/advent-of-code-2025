//
//  Day2.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 2/12/25.
//

struct Day2: DailySolvable {

    struct Range {

        let start: Int
        let end: Int

        init?(_ start: Int, _ end: Int) {
            guard start < end else {
                return nil
            }
            self.start = start
            self.end = end
        }
    }

    static let day = 2

    let ranges: [Range]

    init(input: String) {
        ranges = input
            .trimmingCharacters(in: .newlines)
            .split(separator: ",")
            .compactMap { text -> Range? in
                let components = text.split(separator: "-")
                guard components.count == 2,
                    let start = Int(components[0]),
                    let end = Int(components[1]) else {
                    return nil
                }
                return .init(start, end)
            }
    }

    func answerPart1() -> Int {
        var invalids = 0

        for range in ranges {
            for id in (range.start ... range.end) {
                if checkRepetition(id: id, times: 2) {
                    invalids += id
                }
            }
        }

        return invalids
    }

    func answerPart2() -> Int {
        var invalids = 0

        for range in ranges {
            for id in (range.start ... range.end) {
                if checkRepetition(id: id) {
                    invalids += id
                }
            }
        }

        return invalids
    }
}

extension Day2 {

    private func checkRepetition(id: Int, times: Int? = nil) -> Bool {
        guard id >= 10 else {
            return false
        }

        let digits = Array(String(id))
        let count = digits.count
        let start = times ?? 2
        let end = times ?? count

        if start == 1 {
            return false
        }

        for i in start ... end {
            guard count % i == 0 else {
                continue
            }

            let chunkSize = count / i
            let firstChunk = digits[0 ..< chunkSize]
            var isRepeated = true

            for j in 1 ..< i {
                if digits[j * chunkSize ..< (j + 1) * chunkSize] != firstChunk {
                    isRepeated = false
                    break
                }
            }

            if isRepeated {
                return true
            }
        }

        return false
    }
}
