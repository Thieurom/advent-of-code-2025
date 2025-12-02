import ArgumentParser

let days: [DailySolvable] = []

@main
struct AdventOfCode: ParsableCommand {

    @Option(name: .shortAndLong, help: "The day to solve.")
    var day: Int?

    func run() throws {
        print("Advent Of Code!")

        if let day {
            if let runningDay = days.first(where: { $0.day == day }) {
                print("\(runningDay.name): \(runningDay.answerPart1()) \(runningDay.answerPart2())")
            } else {
                print("There is no day \(day)!")
            }
            return
        }

        for day in days {
            print("\(day.name): \(day.answerPart1()) \(day.answerPart2())")
        }
    }
}
