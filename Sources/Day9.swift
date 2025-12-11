struct Day9: DailySolvable {

    struct Tile: Hashable {

        let x: Int
        let y: Int
    }

    static let day = 9
    let tiles: [Tile]

    init(input: String) {
        tiles = input
            .split(separator: "\n")
            .compactMap { line in
                let components = line.split(separator: ",")
                guard components.count == 2,
                    let x = Int(components[0]),
                    let y = Int(components[1]) else {
                    return nil
                }

                return Tile(x: x, y: y)
            }
    }

    func answerPart1() -> Int {
        var maxArea = 0

        for i in (0 ..< tiles.count - 1) {
            for j in (i + 1 ..< tiles.count) {
                maxArea = max(maxArea, area(a: tiles[i], b: tiles[j]))
            }
        }

        return maxArea
    }
    
    func answerPart2() -> Int {
        var adjacentList = tiles
            .reduce(into: [Tile: [Tile]]()) {
                $0[$1] = []
            }

        for i in (0 ..< tiles.count - 1) {
            for j in (i + 1 ..< tiles.count) {
                let tile1 = tiles[i]
                let tile2 = tiles[j]

                if tile1.x == tile2.x || tile1.y == tile2.y {
                    adjacentList[tile1]?.append(tile2)
                    adjacentList[tile2]?.append(tile1)
                }
            }
        }

        let polygon = getPolygon(from: adjacentList)
        var maxArea = 0

        for i in (0 ..< tiles.count - 1) {
            for j in (i + 1 ..< tiles.count) {
                let tile1 = tiles[i]
                let tile2 = tiles[j]

                let x1 = min(tile1.x, tile2.x)
                let x2 = max(tile1.x, tile2.x)
                let y1 = min(tile1.y, tile2.y)
                let y2 = max(tile1.y, tile2.y)

                let a = Tile(x: x1, y: y1)
                let b = Tile(x: x2, y: y1)
                let c = Tile(x: x2, y: y2)
                let d = Tile(x: x1, y: y2)

                if checkValidRectangle(a, b, c, d, polygon: polygon) {
                    maxArea = max(maxArea, area(a: tile1, b: tile2))
                }
            }
        }

        return maxArea
    }
}

extension Day9 {

    private func area(a: Tile, b: Tile) -> Int {
        (abs(a.x - b.x) + 1) * (abs(a.y - b.y) + 1)
    }

    private func getPolygon(from list: [Tile: [Tile]]) -> [Tile] {
        guard let start = list.keys.first else {
            return []
        }

        var result = [start]
        var visited = Set([start])
        var current = start
        var previous: Tile?

        while true {
            let neighbors = list[current]
                guard let next = neighbors?.first(where: { $0 != previous }) else {
                    break
                }

            if next == start {
                // Polygon closed
                break
            }

            result.append(next)
            visited.insert(next)
            previous = current
            current = next
        }

        return result
    }

    private func checkValidRectangle(_ a: Tile, _ b: Tile, _ c: Tile, _ d: Tile, polygon: [Tile]) -> Bool {
        for tile in [a, b, c, d] {
            if !checkPoint(tile, in: polygon) {
                return false
            }
        }

        let edges = [(a, b), (b, c), (c, d), (d, a)]
        for edge in edges {
            if checkEdgeCrossing(edge.0, edge.1, polygon: polygon) {
                return false
            }
        }

        return true
    }

    private func checkPoint(_ p: Tile, in polygon: [Tile]) -> Bool {
        var inside = false
        let count = polygon.count

        for i in 0 ..< count {
            let a = polygon[i]
            let b = polygon[(i + 1) % count]
            let (p1, p2) = a.y <= b.y ? (a, b) : (b, a)

            if p1.y == p2.y { 
                // Horizontal edge
                if p.y == p1.y && p.x >= min(p1.x, p2.x) && p.x <= max(p1.x, p2.x) {
                    return true
                }
            } else {
                // Vertical edge
                if p.x == p1.x && p.y >= p1.y && p.y <= p2.y {
                    return true
                }

                if p.y > p1.y && p.y <= p2.y && p1.x > p.x {
                    inside.toggle()
                }
            }
        }

        return inside
    }

    private func checkEdgeCrossing(_ a: Tile, _ b: Tile, polygon: [Tile]) -> Bool {
        let count = polygon.count

        for i in (0 ..< polygon.count) {
            let p1 = polygon[i]
            let p2 = polygon[(i + 1) % count]
            let edgeVertical = a.x == b.x
            let pVertical = p1.x == p2.x

            if edgeVertical == pVertical {
                continue
            }

            let v = edgeVertical ? (a, b) : (p1, p2)
            let h = edgeVertical ? (p1, p2) : (a, b)
            let vx = v.0.x
            let hy = h.0.y
            
            let crossesHorizontally = vx > min(h.0.x, h.1.x) && vx < max(h.0.x, h.1.x)
            let crossesVertically = hy > min(v.0.y, v.1.y) && hy < max(v.0.y, v.1.y)

            if crossesHorizontally && crossesVertically {
                return true
            }
        }

        return false
    }
}

