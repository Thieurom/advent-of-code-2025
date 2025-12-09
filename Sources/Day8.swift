struct Day8: DailySolvable {

    struct Coordinate: Hashable {

        let x: Int
        let y: Int
        let z: Int

        func distance(to other: Coordinate) -> Int {
            let deltaX = x - other.x
            let deltaY = y - other.y
            let deltaZ = z - other.z
            return deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ
        }
    }

    static let day = 8

    let boxes: [Coordinate]
    let connections: [(Coordinate, Coordinate)]
    var limit: Int

    init(input: String) {
        boxes = input
            .split(separator: "\n")
            .compactMap { line in
                let components = line.split(separator: ",")
                guard components.count == 3,
                    let x = Int(components[0]),
                    let y = Int(components[1]),
                    let z = Int(components[2]) else {
                    return nil
                }
                return Coordinate(x: x, y: y, z: z)
            }

        var connections = [(Coordinate, Coordinate)]()
        for i in (0 ..< boxes.count - 1) {
            for j in (i + 1 ..< boxes.count) {
                connections.append((boxes[i], boxes[j]))
            }
        }

        connections.sort {
            $0.0.distance(to: $0.1) < $1.0.distance(to: $1.1)
        }

        self.connections = connections
        limit = 1000
    }

    func answerPart1() -> Int {
        var circuits = [Set<Coordinate>]()

        for i in (0 ..< min(connections.count, limit)) {
            let start = connections[i].0
            let end = connections[i].1

            let startIndex = circuits.firstIndex { $0.contains(start) }
            let endIndex = circuits.firstIndex { $0.contains(end) }

            if startIndex == nil && endIndex == nil {
                circuits.append(Set([start, end]))
            } else {
                if startIndex == nil {
                    var circuit = circuits[endIndex!]
                    circuit.insert(start)
                    circuit.insert(end)
                    circuits[endIndex!] = circuit
                } else if endIndex == nil {
                    var circuit = circuits[startIndex!]
                    circuit.insert(start)
                    circuit.insert(end)
                    circuits[startIndex!] = circuit
                } else if startIndex != endIndex {
                    let circuit = circuits[startIndex!].union(circuits[endIndex!])
                    circuits[startIndex!] = circuit
                    circuits.remove(at: endIndex!)
                }
            }
        }

        circuits.sort { $0.count > $1.count }

        return circuits
            .prefix(3)
            .map(\.count)
            .reduce(1, *)
    }
    
    func answerPart2() -> Int {
        var circuits = [Set<Coordinate>]()

        var i = 0
        while i < connections.count {
            let start = connections[i].0
            let end = connections[i].1

            let startIndex = circuits.firstIndex { $0.contains(start) }
            let endIndex = circuits.firstIndex { $0.contains(end) }

            if startIndex == nil && endIndex == nil {
                circuits.append(Set([start, end]))
            } else {
                if startIndex == nil {
                    var circuit = circuits[endIndex!]
                    circuit.insert(start)
                    circuit.insert(end)
                    circuits[endIndex!] = circuit
                } else if endIndex == nil {
                    var circuit = circuits[startIndex!]
                    circuit.insert(start)
                    circuit.insert(end)
                    circuits[startIndex!] = circuit
                } else if startIndex != endIndex {
                    let circuit = circuits[startIndex!].union(circuits[endIndex!])
                    circuits[startIndex!] = circuit
                    circuits.remove(at: endIndex!)
                }
            }

            if circuits.first == Set(boxes) {
                return start.x * end.x
            }
            
            i += 1
        }

        return 0
    }
}
