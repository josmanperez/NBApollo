//
//  ApiRest.swift
//  NBApollo
//
//  Created by Josman Pérez Expósito on 31/03/2020.
//  Copyright © 2020 Josman Pérez Expósito. All rights reserved.
//

import Foundation

public protocol ApiRest {
    associatedtype T
    var urlServer: String { get }
}
