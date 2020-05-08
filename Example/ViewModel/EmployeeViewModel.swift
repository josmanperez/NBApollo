//
//  EmployeeViewModel.swift
//  Example
//
//  Created by Josman Pérez Expósito on 08/05/2020.
//  Copyright © 2020 Josman Pérez Expósito. All rights reserved.
//

import Foundation
import NBApollo


protocol EmployeeViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}

class EmployeeViewModel {
    
    let client = EmployeeClient()
    
    private weak var delegate: EmployeeViewModelDelegate?
    
    private var total: Int = 0
    private var employees:[Employee] = []
    
    init(delegate: EmployeeViewModelDelegate) {
        self.delegate = delegate
    }
    
    var totalEmployees: Int {
        return total
    }
    
    func employee(at index: Int) -> Employee {
        return employees[index]
    }
    
    func fetchEmployees() {
        
        client.fetchEmployees { (result) in
            switch result {
                case .success(let employees):
                    self.employees = employees
                    self.total = employees.count
                    self.delegate?.onFetchCompleted()
                
                case .failure(let error):
                    self.delegate?.onFetchFailed(with: error.reason)
                
            }
        }
        
    }
}
