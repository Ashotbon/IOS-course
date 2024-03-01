//
//  main.swift
//  Day1-ex3
//
//  Created by Ashot Harutyunyan on 2024-02-29.
//

import Foundation

// Swift program to display 7 days of 2 weeks

// outer loop
for week in 1...2 {
  print("Week: \(week)")

// inner loop
    for day in 1...7 {
      print("  Day:  \(day)")
  
   }

// line break after iteration of outer loop
   print("")
}
print("///////////////////////////////")
// program to display 7 days of 2 weeks
var weeks = 2
var i = 1

// outer while loop
while (i <= weeks){
  print("Week: \(i)")

  // inner for loop
  for day in 1...7{
      print("  Day:  \(day)")
    }

    i = i + 1
}
print("///////////////////////////////")

// outer loop
for week in 1...2 {
  print("Week: \(week)")

  // inner loop
  for day in 1...7 {

    // use of continue statement
    if(day % 2 != 0) {
      continue
      }

   print("  Day:  \(day)")
   }

  print("")
}
