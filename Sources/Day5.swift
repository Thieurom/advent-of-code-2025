struct Day5: DailySolvable {

    static let day = 5

    let freshIngredientRanges: [(Int, Int)]
    let availableIngredients: [Int]

    init(input: String) {
        let components = input.split(separator: "\n\n")
        guard components.count == 2 else {
            freshIngredientRanges = []
            availableIngredients = []
            return
        }

        freshIngredientRanges = components[0]
            .split(separator: "\n")
            .compactMap { line in
                let text = line.split(separator: "-")
                guard text.count == 2,
                    let start = Int(text[0]),
                    let end = Int(text[1]),
                    end >= start else {
                    return nil
                }

                return (start, end)
            }

        availableIngredients = components[1]
            .split(separator: "\n")
            .compactMap { Int($0) }
    }

    func answerPart1() -> Int {
        var freshes = 0
        let orderedFreshRanges = joinRanges(freshIngredientRanges)

        for ingredient in availableIngredients {
            if orderedFreshRanges.contains(where: { ingredient >= $0.0 && ingredient <= $0.1 }) {
                freshes += 1
            }
        }

        return freshes
    }
    
    func answerPart2() -> Int {
        let orderedFreshRanges = joinRanges(freshIngredientRanges)

        return orderedFreshRanges
            .reduce(0) { $0 + $1.1 - $1.0 + 1 }
    }
}

extension Day5 {

    private func joinRanges(_ ranges: [(Int, Int)]) -> [(Int, Int)] {
        let orderedRanges = ranges.sorted { $0.0 < $1.0 }
        var result = [(Int, Int)]()

        for range in orderedRanges {
            if var last = result.last, range.0 <= last.1 {
                last.1 = max(last.1, range.1)
                result[result.count - 1] = last
            } else {
                result.append(range)
            }
        }

        return result
    }
}
