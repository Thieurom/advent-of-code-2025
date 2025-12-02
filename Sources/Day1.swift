//
//  Day1.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 2/12/25.
//

struct Day1: DailySolvable {

    enum Direction: String {

        case left = "L"
        case right = "R"
    }

    struct Rotation {

        let direction: Direction
        let distance: Int
    }

    static let day = 1

    let rotations: [Rotation]
    let dials = 100

    init(input: String) {
        rotations = input.split(separator: "\n")
            .compactMap { line -> Rotation? in
                guard line.count >= 2,
                      let direction = Direction(rawValue: .init(line[line.startIndex])),
                      let distance = Int(String(line[line.index(after: line.startIndex) ..< line.endIndex])) else {
                    return nil
                }

                return Rotation(direction: direction, distance: distance)
            }
    }

    func answerPart1() -> Int {
        var pointsAtZero = 0
        var position = 50

        for rotation in rotations {
            switch rotation.direction {
            case .left:
                position += dials - (rotation.distance % dials)
            case .right:
                position += rotation.distance
            }

            position %= dials
            if position == 0 {
                pointsAtZero += 1
            }
        }

        return pointsAtZero
    }
    
    func answerPart2() -> Int {
        var pointAtZero = 0
        var position = 50

        for rotation in rotations {
            switch rotation.direction {
            case .left:
                if position == 0 {
                    position = dials
                }
                position -= rotation.distance
                while position < 0 {
                    position += dials
                    pointAtZero += 1
                }
                if position == 0 {
                    pointAtZero += 1
                }
            case .right:
                position += rotation.distance
                pointAtZero += position / dials
                position %= dials
            }
        }

        return pointAtZero
    }
}
