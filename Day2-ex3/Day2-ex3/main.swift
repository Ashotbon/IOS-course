//
//  main.swift
//  Day2-ex3
//
//  Created by Ashot Harutyunyan on 2024-03-02.
//

//import Foundation
//
//class Person {
//    private var _name: String
//    private var _age: Int
//    private var _city: String
//
//    var name: String {
//        get {
//            return _name
//        }
//        set {
//            guard newValue.count >= 2 && newValue.count <= 100 && !newValue.contains(";") else {
//                fatalError("Name must be 2-100 characters long and not contain semicolons.")
//            }
//            _name = newValue
//        }
//    }
//
//    var age: Int {
//        get {
//            return _age
//        }
//        set {
//            guard newValue >= 0 && newValue <= 150 else {
//                fatalError("Age must be between 0 and 150.")
//            }
//            _age = newValue
//        }
//    }
//
//    var city: String {
//        get {
//            return _city
//        }
//        set {
//            guard newValue.count >= 2 && newValue.count <= 100 && !newValue.contains(";") else {
//                fatalError("City must be 2-100 characters long and not contain semicolons.")
//            }
//            _city = newValue
//        }
//    }
//
//    init(name: String, age: Int, city: String) {
//        _name = ""
//        _age = 0
//        _city = ""
//        self.name = name
//        self.age = age
//        self.city = city
//    }
//
//    func description() -> String {
//        return "\(name) is \(age) from \(city)"
//    }
//}
//
//var people: [Person] = []
//
//func addPersonInfo() {
//    print("Adding a person.")
//    print("Enter name:")
//    guard let name = readLine() else { return }
//    print("Enter age:")
//    guard let ageInput = readLine(), let age = Int(ageInput) else { return }
//    print("Enter city:")
//    guard let city = readLine() else { return }
//
//    let person = Person(name: name, age: age, city: city)
//    people.append(person)
//    print("Person added.")
//}
//
//func listAllPersonsInfo() {
//    print("Listing all persons")
//    for person in people {
//        print(person.description())
//    }
//}
//
//func findPersonByName() {
//    print("Enter partial person name:")
//    guard let name = readLine() else { return }
//    let matches = people.filter { $0.name.contains(name) }
//    print("Matches found:")
//    for match in matches {
//        print(match.description())
//    }
//}
//
//func findPersonYoungerThan() {
//    print("Enter maximum age:")
//    guard let ageInput = readLine(), let age = Int(ageInput) else { return }
//    let matches = people.filter { $0.age < age }
//    print("Matches found:")
//    for match in matches {
//        print(match.description())
//    }
//}
//
//let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("people.txt").path
//
//func readAllPeopleFromFile() {
//    guard let fileContents = try? String(contentsOfFile: filePath) else { return }
//    let lines = fileContents.split(separator: "\n")
//    for line in lines {
//        let components = line.split(separator: ";").map { String($0) }
//        guard components.count == 3, let age = Int(components[1]) else {
//            print("Invalid line: \(line)")
//            continue
//        }
//        let person = Person(name: components[0], age: age, city: components[2])
//        people.append(person)
//    }
//}
//
//func saveAllPeopleToFile() {
//    let data = people.map { "\($0.name);\($0.age);\($0.city)" }.joined(separator: "\n")
//    try? data.write(toFile: filePath, atomically: true, encoding: .utf8)
//}
//
//func main() {
//    readAllPeopleFromFile()
//
//    var shouldContinue = true
//    while shouldContinue {
//        print("""
//        What do you want to do?
//        1. Add person info
//        2. List persons info
//        3. Find a person by name
//        4. Find all persons younger than age
//        0. Exit
//        """)
//        print("Choice: ", terminator: "")
//
//        guard let choice = readLine(), let choiceNum = Int(choice) else {
//            print("Invalid choice try again.")
//            continue
//        }
//
//        switch choiceNum {
//        case 1:
//            addPersonInfo()
//        case 2:
//            listAllPersonsInfo()
//        case 3:
//            findPersonByName()
//        case 4:
//            findPersonYoungerThan()
//        case 0:
//            shouldContinue = false
//            print("Good bye!")
//        default:
//            print("Invalid choice try again.")
//        }
//    }
//
//    saveAllPeopleToFile()
//}
//
//main()


import Foundation

class ArgumentException: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

class Person {
    private var _name: String
    private var _age: Int
    private var _city: String

    var name: String {
        return _name
    }

    var age: Int {
        return _age
    }

    var city: String {
        return _city
    }

    init(name: String, age: Int, city: String) throws {
        _name = ""
        _age = 0
        _city = ""
        try self.setName(name)
        try self.setAge(age)
        try self.setCity(city)
    }

    func setName(_ newName: String) throws {
        guard newName.count >= 2 && newName.count <= 100 && !newName.contains(";") else {
            throw ArgumentException("Name must be 2-100 characters long and not contain semicolons.")
        }
        _name = newName
    }

    func setAge(_ newAge: Int) throws {
        guard newAge >= 0 && newAge <= 150 else {
            throw ArgumentException("Age must be between 0 and 150.")
        }
        _age = newAge
    }

    func setCity(_ newCity: String) throws {
        guard newCity.count >= 2 && newCity.count <= 100 && !newCity.contains(";") else {
            throw ArgumentException("City must be 2-100 characters long and not contain semicolons.")
        }
        _city = newCity
    }

    func description() -> String {
        return "\(name) is \(age) from \(city)"
    }
}

var people: [Person] = []



func addPersonInfo() {
    print("Adding a person.")
    print("Enter name:")
    guard let name = readLine() else { return }
    print("Enter age:")
    guard let ageInput = readLine(), let age = Int(ageInput) else { return }
    print("Enter city:")
    guard let city = readLine() else { return }

    do {
        let person = try Person(name: name, age: age, city: city)
        people.append(person)
        print("Person added.")
    } catch let error as ArgumentException {
        print("Error: \(error.message)")
    } catch {
        print("An unexpected error occurred.")
    }
}

func listAllPersonsInfo() {
    print("Listing all persons")
    for person in people {
        print(person.description())
    }
}

func findPersonByName() {
    print("Enter partial person name:")
    guard let name = readLine() else { return }
    let matches = people.filter { $0.name.contains(name) }
    print("Matches found:")
    for match in matches {
        print(match.description())
    }
}

func findPersonYoungerThan() {
    print("Enter maximum age:")
    guard let ageInput = readLine(), let age = Int(ageInput) else { return }
    let matches = people.filter { $0.age < age }
    print("Matches found:")
    for match in matches {
        print(match.description())
    }
}

let filePath = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!.appendingPathComponent("people.txt").path

func readAllPeopleFromFile() {
    do {
        let fileContents = try String(contentsOfFile: filePath)
        let lines = fileContents.split(separator: "\n")
        for line in lines {
            let components = line.split(separator: ";").map { String($0) }
            guard components.count == 3, let age = Int(components[1]) else {
                print("Invalid line (parsing error): \(line)")
                continue
            }
            do {
                let person = try Person(name: components[0], age: age, city: components[2])
                people.append(person)
            } catch let error as ArgumentException {
                print("Invalid line (validation error): \(line)\nError: \(error.message)")
            } catch {
                print("Invalid line (unexpected error): \(line)")
            }
        }
    } catch {
        print("Failed to read from file: \(error)")
    }
}


func saveAllPeopleToFile() {
    let data = people.map { "\($0.name);\($0.age);\($0.city)" }.joined(separator: "\n")
    do {
        try data.write(toFile: filePath, atomically: true, encoding: .utf8)
    } catch {
        print("Failed to write to file: \(error)")
    }
}
func main() {
    readAllPeopleFromFile()

    var shouldContinue = true
    while shouldContinue {
        print("""
        What do you want to do?
        1. Add person info
        2. List persons info
        3. Find a person by name
        4. Find all persons younger than age
        0. Exit
        """)
        print("Choice: ", terminator: "")

        guard let choice = readLine(), let choiceNum = Int(choice) else {
            print("Invalid choice try again.")
            continue
        }

        switch choiceNum {
        case 1:
            addPersonInfo()
        case 2:
            listAllPersonsInfo()
        case 3:
            findPersonByName()
        case 4:
            findPersonYoungerThan()
        case 0:
            shouldContinue = false
            print("Good bye!")
        default:
            print("Invalid choice try again.")
        }
    }

    saveAllPeopleToFile()
}

main()
