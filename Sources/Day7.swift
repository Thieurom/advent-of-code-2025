struct Day7: DailySolvable {

    static let day = 7

    let lines: [[String]]

    init(input: String) {
        lines = input
            .split(separator: "\n")
            .map { $0.map(String.init) }
    }

    func answerPart1() -> Int {
        guard !lines.isEmpty else {
            return 0
        }

        var beams = [Bool](repeating: false, count: lines[0].count)
        var count = 0

        for line in lines {
            for (i, cell) in line.enumerated() {
                if cell == "S" {
                    beams[i] = true
                } else if cell == "^" && beams[i] {
                    count += 1
                    beams[i] = false

                    if i >= 1 {
                        beams[i - 1] = true
                    }

                    if i < line.count - 1 {
                        beams[i + 1] = true
                    }
                }
            }
        }

        return count
    }
    
    func answerPart2() -> Int {
        guard !lines.isEmpty else {
            return 0
        }

        var beams = [Int](repeating: 0, count: lines[0].count)
        var count = 0

        for line in lines {
            for (i, cell) in line.enumerated() {
                if cell == "S" {
                    beams[i] = 1
                    count = 1
                } else if cell == "^" && beams[i] > 0 {
                    let beam = beams[i]
                    count += beam
                    beams[i] = 0

                    if i >= 1 {
                        beams[i - 1] += beam
                    }

                    if i < line.count - 1 {
                        beams[i + 1] += beam
                    }
                }
            }
        }

        return count
    }
}
