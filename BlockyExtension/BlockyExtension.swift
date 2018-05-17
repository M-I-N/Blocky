//
//  BlockyExtension.swift
//  BlockyExtension
//
//  Created by Nayem on 4/17/18.
//  Copyright © 2018 Mufakkharul Islam Nayem. All rights reserved.
//

import IdentityLookup

final class BlockyExtension: ILMessageFilterExtension {

    /*private var words = [String]()
    private lazy var wordsToFiler: [String] = {
        if let words = storageController.fetchFilter()?.words {
            let capitalizedWords = words.map { $0.capitalized }
            let uppercasedWords = words.map { $0.uppercased() }
            self.words = words + capitalizedWords + uppercasedWords
        }
        return self.words
    }()*/

    private lazy var wordsToFiler: [String] = {
        return storageController.fetchWordFilter()?.words ?? [String]()
    }()

    private lazy var numbersToFilter: [String] = {
        return storageController.fetchNumberFilter()?.numbers ?? [String]()
    }()

    let storageController = StorageController()

}

extension BlockyExtension: ILMessageFilterQueryHandling {
    
    func handle(_ queryRequest: ILMessageFilterQueryRequest, context: ILMessageFilterExtensionContext, completion: @escaping (ILMessageFilterQueryResponse) -> Void) {
        // First, check whether to filter using offline data (if possible).
        let offlineAction = self.offlineAction(for: queryRequest)
        
        switch offlineAction {
        case .allow, .filter:
            // Based on offline data, we know this message should either be Allowed or Filtered. Send response immediately.
            let response = ILMessageFilterQueryResponse()
            response.action = offlineAction
            
            completion(response)
            
        case .none:
            // Based on offline data, we do not know whether this message should be Allowed or Filtered. Defer to network.
            // Note: Deferring requests to network requires the extension target's Info.plist to contain a key with a URL to use. See documentation for details.
            context.deferQueryRequestToNetwork() { (networkResponse, error) in
                let response = ILMessageFilterQueryResponse()
                response.action = .none
                
                if let networkResponse = networkResponse {
                    // If we received a network response, parse it to determine an action to return in our response.
                    response.action = self.action(for: networkResponse)
                } else {
                    NSLog("Error deferring query request to network: \(String(describing: error))")
                }
                
                completion(response)
            }
        }
    }
    
    private func offlineAction(for queryRequest: ILMessageFilterQueryRequest) -> ILMessageFilterAction {
        // Replace with logic to perform offline check whether to filter first (if possible).
        guard let messageBody = queryRequest.messageBody, let messageSender = queryRequest.sender else {
            return .none
        }
//        print(messageSender)
//        print(messageBody)
//        print(wordsToFiler)
        return wordsToFiler.map { $0.lowercased() }.contains(where: messageBody.lowercased().contains) || numbersToFilter.contains(messageSender) ? .filter : .none
    }
    
    private func action(for networkResponse: ILNetworkResponse) -> ILMessageFilterAction {
        // Replace with logic to parse the HTTP response and data payload of `networkResponse` to return an action.
        return .none
    }
    
}
