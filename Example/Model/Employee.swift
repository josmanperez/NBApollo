//
//  Employee.swift
//  Example
//
//  Created by Josman Pérez Expósito on 08/05/2020.
//  Copyright © 2020 Josman Pérez Expósito. All rights reserved.
//

import Foundation

/// Employee class
/// Conforms to protocol Employee
class Employee: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "employee_name"
        case salary = "employee_salary"
        case age = "employee_age"
        case profileImage = "profile_image"
    }
    
    var id: String
    var name: String
    var salary: String
    var age: String
    var profileImage: String
}
