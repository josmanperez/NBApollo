//
//  EmployeeResponse.swift
//  Example
//
//  Created by Josman Pérez Expósito on 08/05/2020.
//  Copyright © 2020 Josman Pérez Expósito. All rights reserved.
//

import Foundation

/// Class to habdle the response of the server
/// Status Bool for the data
/// Data is a Decodable object
class EmployeeResponse<T: Decodable>: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
    
    var status: String
    var data: T
}
