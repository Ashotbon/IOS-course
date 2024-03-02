//
//  main.swift
//  Day2-ex2
//
//  Created by Ashot Harutyunyan on 2024-03-01.
//


import Foundation

var namesList: [String] = []
var numsList: [Double] = []

// Use the full path to the 'input.txt' file on your Desktop.
let inputPath = "/Users/ashotharutyunyan/Desktop/IOS-course/Day2-ex2/Day2-ex2/input.txt"
let duplicatesPath = "/Users/ashotharutyunyan/Desktop/IOS-course/Day2-ex2/Day2-ex2/Duplicate_names.txt"

do {
    let contents = try String(contentsOfFile: inputPath, encoding: .utf8)
    let lines = contents.split(separator: "\n")

    for line in lines {
        if let number = Double(line) {
            numsList.append(number)
        } else {
            namesList.append(String(line))
        }
    }

    // 1. Sort names alphabetically.
    namesList.sort(by: <)

    // 2. Sort numbers from smallest to largest.
    numsList.sort(by: <)

    // 3. Display names (sorted) on a single line, comma-separated.
    print(namesList.joined(separator: ", "))

    // 4. Display numbers (sorted) on a single line, comma-separated.
    print(numsList.map { String($0) }.joined(separator: ", "))

    // 5. Compute the average length of names in characters (floating point) and display it.
    let totalLength = namesList.map { $0.count }.reduce(0, +)
    let averageLength = namesList.isEmpty ? 0 : Double(totalLength) / Double(namesList.count)
    print("Average length of names: \(averageLength)")

    // 6. Find and display any names that occur more than once in the list.
    let nameCounts = namesList.reduce(into: [:]) { counts, name in counts[name, default: 0] += 1 }
    let duplicates = nameCounts.filter { $1 > 1 }.map { $0.key }
    print("Duplicate names: \(duplicates.joined(separator: ", "))")

    // 7. Write the list from item 6 into "duplicates.txt" file, one per line.
    let duplicatesString = duplicates.joined(separator: "\n")
    try duplicatesString.write(toFile: duplicatesPath, atomically: true, encoding: .utf8)

} catch {
    print("An error occurred: \(error)")
}
