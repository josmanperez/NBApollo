//
//  Result.swift
//  NBApollo
//
//  Created by Josman Pérez Expósito on 16/04/2020.
//  Copyright © 2020 Josman Pérez Expósito. All rights reserved.
//

import Foundation

public enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}
