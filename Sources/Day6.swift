struct Day6: DailySolvable {

    static let day = 6

    let lines: [String]

    init(input: String) {
        lines = input
            .split(separator: "\n")
            .map(String.init)
    }

    func answerPart1() -> Int {
        let operandsList = lines
            .dropLast()
            .map { line in
                line
                    .split(separator: " ")
                    .compactMap { Int($0) }
            }
            .reduce(into: [[Int]]()) { list, element in
                // Transpose!
                if list.isEmpty {
                    list = element.map { [$0] }
                } else {
                    for i in (0 ..< list.count) {
                        list[i].append(element[i])
                    }
                }
            }

        let operationsList = lines .last
            .map { $0.split(separator: " ") } ?? []

        return zip(operandsList, operationsList)
            .map {
                switch $1 {
                case "+":
                    $0.reduce(0, +)
                case "*":
                    $0.reduce(1, *)
                default:
                    0
                }
            }
            .reduce(0, +)
    }
    
    func answerPart2() -> Int {
        let matrix = lines
            .map { line in
                line.map(String.init)
            }

        let rows = matrix.count
        let columns = matrix[rows - 1].count
        var sum = 0
        var operand = ""
        var result = 0

        for c in (0 ..< columns) {
            let op = matrix[rows - 1][c]
            if !op.trimmingCharacters(in: .whitespaces).isEmpty {
                operand = op
                sum += result
                result = operand == "+" ? 0 : 1
            }

            var number = 0
            for r in (0 ..< rows - 1) {
                let digit = matrix[r][c]
                guard !digit.trimmingCharacters(in: .whitespaces).isEmpty else {
                    continue
                }
                number = number * 10 + (Int(digit) ?? 0)
            }
            guard number != 0 else {
                continue
            }

            if operand == "+" {
                result += number
            } else {
                result *= number
            }
        }

        return sum + result
    }
}
