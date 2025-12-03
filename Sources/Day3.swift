struct Day3: DailySolvable {

    static let day = 3

    let batteries: [[Int]]

    init(input: String) {
        batteries = input.split(separator: "\n")
            .map { $0.map(String.init) }
            .map { $0.compactMap { Int($0) } }
    }

    func answerPart1() -> Int {
        batteries
            .reduce(0) {
                $0 + getTwoBatteriesJoltage(bank: $1)
            }
    }
    
    func answerPart2() -> Int {
        batteries
            .reduce(0) {
                $0 + getTwelveBatteriesJoltage(bank: $1)
            }
    }
}

extension Day3 {

    private func getTwoBatteriesJoltage(bank: [Int]) -> Int {
        guard bank.count >= 2 else {
            return 0
        }

        var maxBattery = max(bank[0], bank[1])
        var maxJoltage = bank[0] * 10 + bank[1]

        for battery in bank.dropFirst(2) {
            let joltage = maxBattery * 10 + battery
            if joltage > maxJoltage {
                maxJoltage = joltage
            }
            if battery > maxBattery {
                maxBattery = battery
            }
        }

        return maxJoltage
    }

    private func getTwelveBatteriesJoltage(bank: [Int]) -> Int {
        guard bank.count >= 12 else {
            return 0
        }

        var deletions = bank.count - 12
        var stack = [Int]()

        for battery in bank {
            while deletions > 0, let last = stack.last, last < battery {
                stack.removeLast()
                deletions -= 1
            }
            stack.append(battery)
        }

        return stack
            .prefix(12)
            .reduce(0) { $0 * 10 + $1 }
    }
}

