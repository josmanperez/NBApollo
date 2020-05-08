//
//  Employee.swift
//  Example
//
//  Created by Josman Pérez Expósito on 08/05/2020.
//  Copyright © 2020 Josman Pérez Expósito. All rights reserved.
//

import Foundation

/// User class
/// Conforms to protocol Decodable
class User: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
    }
    
    var id: Int
    var name: String
    var username: String
    var email: String
}
