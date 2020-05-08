//
//  EmployeeCell.swift
//  Example
//
//  Created by Josman Pérez Expósito on 08/05/2020.
//  Copyright © 2020 Josman Pérez Expósito. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    static let reuseIdentifier = "cell"
    
    @IBOutlet weak var name: UILabel!
    
    /// Configure the Cell with the object Employee
    func configureCell(e: User) {
        name.text = e.name
    }

}
