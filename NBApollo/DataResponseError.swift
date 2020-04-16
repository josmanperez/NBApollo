//
//  DataResponseError.swift
//  NBApollo
//
//  Created by Josman Pérez Expósito on 16/04/2020.
//  Copyright © 2020 Josman Pérez Expósito. All rights reserved.
//

import Foundation

/// Enum for handle network request error
public enum DataResponseError: Error {
    case network
    case decoding
    case custom(message: String)

    public var reason: String {
        switch self {
            case .network:
                return NSLocalizedString("An error occurred while fetching data", comment: "fetching error")
            case .decoding:
                return NSLocalizedString("An error occurred while decoding data", comment: "decoding error")
            case .custom(let message):
                return NSLocalizedString(message, comment: "custom error")
        }
    }
}


