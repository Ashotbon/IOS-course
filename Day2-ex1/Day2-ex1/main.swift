//
//  main.swift
//  Day2-ex1
//
//  Created by Ashot Harutyunyan on 2024-03-01.
//

import Foundation

func generateRandomNumbers(count: Int, min: Int, max: Int) -> [Int] {
    return (1...count).map({ _ in Int.random(in: min...max) })
}


print("How many random numbers do you want to generate?")
guard let countInput = readLine(), let count = Int(countInput), count > 0 else {
    print("Error: Please enter a positive integer number.")
    exit(1)
}


print("Enter the minimum integer value:")
guard let minInput = readLine(), let min = Int(minInput) else {
    print("Error: Invalid input for minimum value. Please enter an integer.")
    exit(1)
}


print("Enter the maximum integer value:")
guard let maxInput = readLine(), let max = Int(maxInput) else {
    print("Error: Invalid input for maximum value. Please enter an integer.")
    exit(1)
}


if min > max {
    print("Error: The minimum value cannot be larger than the maximum value.")
    exit(1)
}


let randomNumbers = generateRandomNumbers(count: count, min: min, max: max)
print(randomNumbers.map(String.init).joined(separator: ", "))


/*
 import Foundation

 func generateRandomNumbers(count: Int, min: Int, max: Int) -> [Int] {
     return (1...count).map({ _ in Int.random(in: min...max) })
 }

 print("How many random numbers do you want to generate?")
 if let countInput = readLine(), let count = Int(countInput), count > 0 {
     print("Enter the minimum integer value:")
     if let minInput = readLine(), let min = Int(minInput) {
         print("Enter the maximum integer value:")
         if let maxInput = readLine(), let max = Int(maxInput) {
             if min <= max {
                 let randomNumbers = generateRandomNumbers(count: count, min: min, max: max)
                 print(randomNumbers.map(String.init).joined(separator: ", "))
             } else {
                 print("Error: The minimum value cannot be larger than the maximum value.")
             }
         } else {
             print("Error: Invalid input for maximum value. Please enter an integer.")
         }
     } else {
         print("Error: Invalid input for minimum value. Please enter an integer.")
     }
 } else {
     print("Error: Please enter a positive integer number.")
 }
 */
