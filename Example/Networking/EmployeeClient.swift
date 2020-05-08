//
//  EmployeeClient.swift
//  Example
//
//  Created by Josman Pérez Expósito on 08/05/2020.
//  Copyright © 2020 Josman Pérez Expósito. All rights reserved.
//

import NBApollo

/// Class for handle the Configuration.plist where all the endpoints are placed
class EmployeeConfiguration: ApiRawValueProtocol {

    /// The name of the plist file where the endpoints are
    var apiConfiguration: String = "Configuration"
    /// type of the file. Is a plist
    var plist: String = "plist"

    /// Name of the key for the url
    var endpoint = "endpoint"
}

class EmployeeClient {

    /// Variable to return the base URL.
    /// It reads from a Configuration file the strings of the base url
    /// and returns it.
    /// If there is an error reading the configuration file it returns an empty String
    private lazy var baseURL: String = {
        let configuration = EmployeeConfiguration()
        let frm = FileReadManager(withConfig: configuration)
        do {
            let url = try frm.getApiValue(with: configuration.endpoint)
            return url
        } catch {
            return ""
        }
    }()

    /// Function to fetch employees.
    /// Completion handler to closure.
    func fetchEmployees(completion: @escaping (Result<[Employee], DataResponseError>) -> Void) {
        let request = ApiRestClient<EmployeeResponse<[Employee]>>(urlServer: baseURL)
        request.request(method: .get, parameters: nil) { (response) in
            switch response {
                case .failure(let error):
                    completion(Result.failure(error))
                
                case .success(let response):
                    if response.status == "success" {
                        completion(Result.success(response.data))
                    } else {
                        completion(Result.failure(DataResponseError.custom(message: "Response status is: \(response.status)")))
                }
            }
        }
    }
    
}
