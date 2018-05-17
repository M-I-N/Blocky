//
//  StorageController.swift
//  Blocky
//
//  Created by Nayem BJIT on 4/18/18.
//  Copyright © 2018 BJIT Ltd. All rights reserved.
//

import Foundation
import CallKit

class StorageController {
    let userDefaults = UserDefaults(suiteName: Constants.userDefaultsSuiteKey)!

    func save(wordFilter: WordFilter) {
        let encoder = JSONEncoder()
        do {
            let encodedFilter = try encoder.encode(wordFilter)
            userDefaults.set(encodedFilter, forKey: Constants.wordsFilterUserDefaultsKey)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchWordFilter() -> WordFilter? {
        if let data = userDefaults.data(forKey: Constants.wordsFilterUserDefaultsKey) {
            let decoder = JSONDecoder()
            do {
                let decodedFilter = try decoder.decode(WordFilter.self, from: data)
                return decodedFilter
            } catch {
                print(error.localizedDescription)
                return nil
            }
        } else {
            print("No initial filtering word exists")
            return nil
        }
    }

    func save(numberFilter: NumberFilter) {
        let encoder = JSONEncoder()
        do {
            let encodedFilter = try encoder.encode(numberFilter)
            userDefaults.set(encodedFilter, forKey: Constants.numbersFilterUserDefaultsKey)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchNumberFilter() -> NumberFilter? {
        if let data = userDefaults.data(forKey: Constants.numbersFilterUserDefaultsKey) {
            let decoder = JSONDecoder()
            do {
                let decodedFilter = try decoder.decode(NumberFilter.self, from: data)
                return decodedFilter
            } catch {
                print(error.localizedDescription)
                return nil
            }
        } else {
            print("No initial filtering number exists")
            return nil
        }
    }

    func save(callBlocks: [CallBlock]) {
        let encoder = JSONEncoder()
        do {
            let encodedCallBlocks = try encoder.encode(callBlocks)
            userDefaults.set(encodedCallBlocks, forKey: Constants.blockedCallsUserDefaultsKey)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchCallBlocks() -> [CallBlock] {
        if let data = userDefaults.data(forKey: Constants.blockedCallsUserDefaultsKey) {
            let decoder = JSONDecoder()
            do {
                let decodedCallBlocks = try decoder.decode([CallBlock].self, from: data)
                return decodedCallBlocks
            } catch {
                print(error.localizedDescription)
                return []
            }
        } else {
            print("No initial call blocking number exists")
            return []
        }
    }

    func loadAllPhoneNumbersToBeBlocked() -> [CXCallDirectoryPhoneNumber] {
        let callBlocks = fetchCallBlocks()
        let allPhoneNumbers = callBlocks.map { CXCallDirectoryPhoneNumber($0.phoneNumber) ?? 1888_555_5555 }
        // Remove the duplicate entries
        let setWithAllPhoneNumbers = Set(allPhoneNumbers).sorted()
        return setWithAllPhoneNumbers
    }

    func loadIncrementalPhoneNumbersToBeBlocked() -> (add : [CXCallDirectoryPhoneNumber], remove : [CXCallDirectoryPhoneNumber]) {
        let (all, markedAsAdded) = loadBlockList()
        let numbersToBeAdded = all.filter { return !markedAsAdded.contains($0) }.sorted()
        let numbersToBeRemoved = markedAsAdded.filter { return !all.contains($0) }.sorted()
        return (numbersToBeAdded, numbersToBeRemoved)
    }

    private func loadBlockList() -> (all: [CXCallDirectoryPhoneNumber], markedAsAdded: [CXCallDirectoryPhoneNumber]) {
        return (loadAllPhoneNumbersToBeBlocked(), recordedBlockListSetOfPhoneNumbers())
    }

    func updateRecordedBlockListSetOf(addedPhoneNumbers: [CXCallDirectoryPhoneNumber], removedPhoneNumbers: [CXCallDirectoryPhoneNumber]) {
        let previouslyAddedToBlockList = recordedBlockListSetOfPhoneNumbers()
        let blockListByAddingNew = previouslyAddedToBlockList + addedPhoneNumbers
        let newBlockList = blockListByAddingNew.filter { return !removedPhoneNumbers.contains($0) }

        /*let recordedBlockList = fetchAlreadyBlockListedPhoneNumbers()
        let blockListAfterDeletingRemovedNumbers = recordedBlockList.filter { return !removedPhoneNumbers.contains($0) }
        let blockListAfterInsertingAddedNumbers = blockListAfterDeletingRemovedNumbers + addedPhoneNumbers*/

        let encoder = JSONEncoder()
        do {
            let encodedPhoneNumbers = try encoder.encode(newBlockList)
            userDefaults.set(encodedPhoneNumbers, forKey: Constants.phoneNumbersAddedToBlockList)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private func recordedBlockListSetOfPhoneNumbers() -> [CXCallDirectoryPhoneNumber] {
        if let data = userDefaults.data(forKey: Constants.phoneNumbersAddedToBlockList) {
            let decoder = JSONDecoder()
            do {
                let decodedPhoneNumbers = try decoder.decode([CXCallDirectoryPhoneNumber].self, from: data)
                return decodedPhoneNumbers
            } catch {
                print(error.localizedDescription)
                return []
            }
        } else {
            print("No phone numbers are already in saved blocked list")
            return []
        }
    }

}

