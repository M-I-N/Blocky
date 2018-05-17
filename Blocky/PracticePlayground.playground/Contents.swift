//: Playground - noun: a place where people can play

import UIKit
import CallKit

let words = ["offer", "subscribe", "register"]
let capitalizedWords = words.map { $0.capitalized }
let uppercasedWords = words.map { $0.uppercased() }

let allWords = words + capitalizedWords + uppercasedWords
let sentence = "Today is the last day of the offer. Please SUBSCRIBE"

let result = allWords.contains(where: sentence.contains)

let allNumbers: [Int] = [123, 456, 789, 790, 999]
let savedNumbers: [Int] = [123, 456, 789, 790, 795]
let newNumbersToBeAdded = allNumbers.filter { !savedNumbers.contains($0) }
//print(newNumbersToBeAdded)
let numbersToBeDeleted = savedNumbers.filter { !allNumbers.contains($0) }
//print(numbersToBeDeleted)

let numbers = [ 123, 456, 789, 790, 795]
let add = [ 689, 697, 836 ]
let remove = [ 456, 790 ]

let numbersByAddingNew = numbers + add
let numbersAfterRemoving = numbersByAddingNew.filter { return !remove.contains($0) }.sorted()
//print(numbersAfterRemoving)

let phoneNumber: CXCallDirectoryPhoneNumber = CXCallDirectoryPhoneNumber("+8801684505025")!
print(phoneNumber)

let numbersToFilter = [ "+818033101388", "+880 168 450 5025" ].map { $0.trimmingCharacters(in: .whitespaces) }
let messageSender = "+818033101388"
let shouldFilter = numbersToFilter.contains(messageSender)
//"+880 1768-835619".replacingOccurrences(of: "+", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")

