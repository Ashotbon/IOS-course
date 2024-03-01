//
//  main.swift
//  Day1-ex4
//
//  Created by Ashot Harutyunyan on 2024-02-29.
//

import Foundation

var languages = ["Swift", "Java", "C++"]

// access element at index 0
print(languages[0])   // Swift

// access element at index 2
print(languages[2])   // C++
print("///////////////////////////////")
var numbers = [21, 34, 54, 12]

print("Before Append: \(numbers)")

// using append method
numbers.append(32)

print("After Append: \(numbers)")

print("///////////////////////////////")

var primeNumbers = [2, 3, 5]
print("Array1: \(primeNumbers)")

var evenNumbers = [4, 6, 8]
print("Array2: \(evenNumbers)")

// join two arrays
primeNumbers.append(contentsOf: evenNumbers)

print("Array after append: \(primeNumbers)")




