//
//  EmployeeViewModel.swift
//  Example
//
//  Created by Josman Pérez Expósito on 08/05/2020.
//  Copyright © 2020 Josman Pérez Expósito. All rights reserved.
//

import Foundation
import NBApollo


protocol UsersViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}

class UsersViewModel {
    
    let client = UserClient()
    
    private weak var delegate: UsersViewModelDelegate?
    
    private var total: Int = 0
    private var users:[User] = []
    
    init(delegate: UsersViewModelDelegate) {
        self.delegate = delegate
    }
    
    var totalEmployees: Int {
        return total
    }
    
    func user(at index: Int) -> User {
        return users[index]
    }
    
    func fetchEmployees() {
        
        client.fetchEmployees { (result) in
            switch result {
                case .success(let users):
                    self.users = users
                    self.total = users.count
                    self.delegate?.onFetchCompleted()
                
                case .failure(let error):
                    self.delegate?.onFetchFailed(with: error.reason)
                
            }
        }
        
    }
}
