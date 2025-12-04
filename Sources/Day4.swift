struct Day4: DailySolvable {

    static let day = 4

    let grid: [[String]]

    init(input: String) {
        grid = input.split(separator: "\n")
            .map { $0.map(String.init) }
    }

    func answerPart1() -> Int {
        getAccessiblePositions(grid).count
    }
    
    func answerPart2() -> Int {
        var grid = grid
        var removed = 0

        while true {
            let positions = getAccessiblePositions(grid)
            if positions.isEmpty {
                break
            }

            removed += positions.count
            removeRollsOfPaper(positions, from: &grid)
        } 

        return removed
    }
}

extension Day4 {

    private func getAccessiblePositions(_ grid: [[String]]) -> [(Int, Int)] {
        var positions = [(Int, Int)]()

        for i in (0 ..< grid.count) {
            for j in (0 ..< grid[i].count) {
                guard grid[i][j] == "@" else {
                    continue
                }

                let adjacent = [
                    (-1, -1), (-1, 0), (-1, 1),
                    (0,  -1),          (0, 1),
                    (1,  -1),  (1, 0), (1, 1)
                ].map { (i + $0.0, j + $0.1) }

                var count = 0

                for (row, column) in adjacent {
                    guard row >= 0, row < grid.count,  column >= 0, column < grid[row].count else {
                        continue
                    }
                    if grid[row][column] == "@" {
                        count += 1
                    }
                    if count == 4 {
                        break
                    }
                }

                if count < 4 {
                    positions.append((i, j))
                }
            }
        }

        return positions
    }

    private func removeRollsOfPaper(_ positions: [(Int, Int)], from grid: inout [[String]]) {
        for (row, column) in positions {
            grid[row][column] = "x"
        }
    }
}
