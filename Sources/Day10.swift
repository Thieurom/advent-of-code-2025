struct Day10: DailySolvable {

    struct Component {

        let lights: [Int]
        let buttons: [[Int]]
    }

    static let day = 10
    let components: [Component]

    init(input: String) {
        components = input
            .split(separator: "\n")
            .compactMap { line -> Component? in
                let components = line
                    .trimmingCharacters(in: .init(charactersIn: "[}"))
                    .components(separatedBy: ["]", "{"])

                guard components.count == 3 else {
                    return nil
                }

                let lights = components[0]
                    .compactMap {
                        switch $0 {
                        case ".": 0
                        case "#": 1
                        default: nil
                        }
                    }

                let buttons = components[1]
                    .split(separator: " ")
                    .map { $0.trimmingCharacters(in: .init(charactersIn: "()")) }
                    .compactMap { text -> [Int]? in
                        let numbers = text
                            .split(separator: ",")
                            .compactMap { Int($0) }
                        if numbers.isEmpty {
                            return nil
                        }
                        return numbers
                    }

                return Component(lights: lights, buttons: buttons)
            }
    }

    func answerPart1() -> Int {
        var totalPresses = 0

        for component in components {
            totalPresses += switchLights(component.lights, component.buttons)
        }
        
        return totalPresses
    }
    
    func answerPart2() -> Int {
        0
    }
}

extension Day10 {

    private func switchLights(_ lights: [Int], _ buttons: [[Int]]) -> Int {
        let lightsValue = lights
            .reduce(0) {
                $0 * 2 + $1
            }

        var minSwitch = Int.max

        for options in PowerSet(buttons) {
            var off = 0
            for option in options {
                var mask = 0
                for button in option {
                    let index = lights.count - 1 - button
                    mask |= 1 << index
                }
                off ^= mask
            }

            if off == lightsValue {
                minSwitch = min(minSwitch, options.count)
            }
        }

        return minSwitch
    }
}

struct PowerSet<Element>: Sequence, IteratorProtocol {

    let elements: [Element]
    var mask: Int = 0

    init(_ elements: [Element]) {
        self.elements = elements
    }

    mutating func next() -> [Element]? {
        let maxMask = 1 << elements.count
        if mask == maxMask { return nil }

        var subset: [Element] = []
        for i in 0..<elements.count {
            if (mask >> i) & 1 == 1 {
                subset.append(elements[i])
            }
        }

        mask += 1
        return subset
    }
}
