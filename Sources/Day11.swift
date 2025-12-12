struct Day11: DailySolvable {

    static let day = 11

    let devices: [String: [String]]

    init(input: String) {
        devices = input
            .split(separator: "\n")
            .compactMap { line -> (String, [String])? in
                let components = line.split(separator: ":")
                guard components.count == 2 else {
                    return nil
                }
                return (
                    String(components[0]),
                    components[1]
                        .split(separator: " ")
                        .map(String.init)
                )
            }
            .reduce(into: [:]) {
                $0[$1.0] = $1.1
            }
    }

    func answerPart1() -> Int {
        countPaths(
            from: "you",
            to: "out",
        )
    }

    func answerPart2() -> Int {
        let p1 = countPaths(from: "svr", to: "fft")
        let p2 = countPaths(from: "fft", to: "dac")
        let p3 = countPaths(from: "dac", to: "out")

        let q1 = countPaths(from: "svr", to: "dac")
        let q2 = countPaths(from: "dac", to: "fft")
        let q3 = countPaths(from: "fft", to: "out")

        return p1 * p2 * p3 + q1 * q2 * q3
    }
}

extension Day11 {

    private func countPaths(
        from: String,
        to target: String
    ) -> Int {
        var visited = Set<String>()
        return countPaths(
            from: from,
            to: target,
            visited: &visited
        )
    }

    private func countPaths(
        from: String,
        to target: String,
        visited: inout Set<String>
    ) -> Int {
        if from == target {
            return 1
        }

        visited.insert(from)
        var total = 0

        for neighbor in devices[from, default: []] where !visited.contains(neighbor) {
            total += countPaths(
                from: neighbor,
                to: target,
                visited: &visited
            )
        }

        visited.remove(from)

        return total
    }
}
