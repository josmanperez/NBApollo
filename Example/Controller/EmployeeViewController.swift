//
//  ViewController.swift
//  Example
//
//  Created by Josman Pérez Expósito on 08/05/2020.
//  Copyright © 2020 Josman Pérez Expósito. All rights reserved.
//

import UIKit

class EmployeeViewController: UIViewController, EmployeeViewModelDelegate {
    
    private var viewModel: EmployeeViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel = EmployeeViewModel(delegate: self)
        
        viewModel.fetchEmployees()
    }
    
    
    // MARK: - Delegates from ViewModel
    func onFetchCompleted() {
        tableView.reloadData()
    }
    
    func onFetchFailed(with reason: String) {
        print(reason)
    }
    
    
}

extension EmployeeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.reuseIdentifier, for: indexPath) as? EmployeeCell {
            let employee = viewModel.employee(at: indexPath.row)
            cell.configureCell(e: employee)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.totalEmployees
    }
    
    
}

