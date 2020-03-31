//
//  ApiRest.swift
//  NBApollo
//
//  Created by Josman Pérez Expósito on 31/03/2020.
//  Copyright © 2020 Josman Pérez Expósito. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiRest {
    associatedtype T
    var urlServer: String { get }
    func request(method: HTTPMethod, parameters: [String:String]?, completionHandler: @escaping ((Bool, T?) -> Void))
    func request(with headers: HTTPHeaders, method: HTTPMethod, parameters: [String:String]?, completionHandler: @escaping ((Bool, T?) -> Void))
}
