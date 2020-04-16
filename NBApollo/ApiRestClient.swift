//
//  ApiRestClient.swift
//  NBApollo
//
//  Created by Josman Pérez Expósito on 31/03/2020.
//  Copyright © 2020 Josman Pérez Expósito. All rights reserved.
//

import Alamofire

/// Clase for handle API Rest request
public class ApiRestClient<T:Decodable>: ApiRest {
    
    public var urlServer: String

    public init(urlServer: String) {
        self.urlServer = urlServer
    }

    // Method to request
    /// - Returns: CompletionHandler with a tuple of Bool regarding the success and object result that conforms protocol Decodable
    public func request(method: HTTPMethod, parameters: [String : String]?, completionHandler: @escaping (Result<T,DataResponseError>) -> Void) {
        dorequest(url: self.urlServer, method: method, parameters: parameters, completionHandler: completionHandler)
    }

    /// Method to request with headers
    public func request(with headers: HTTPHeaders, method: HTTPMethod, parameters: [String : String]?, completionHandler: @escaping (Result<T,DataResponseError>) -> Void) {
        dorequest(url: self.urlServer, headers: headers, method: method, parameters: parameters, completionHandler: completionHandler)
    }

    fileprivate func dorequest(url: String, headers: HTTPHeaders? = nil, method: HTTPMethod, parameters: [String: String]? = nil, completionHandler: @escaping (Result<T,DataResponseError>) -> Void) {
        Alamofire.request(url, method: method, parameters: parameters, headers: headers).responseJSON {
            response in
            switch response.result {
                case .success( _):
                    guard let data = response.data else {
                        completionHandler(Result.failure(.network))
                        return
                    }
                    let decoder = JSONDecoder()
                    do {
                        let results = try decoder.decode(T.self, from: data)
                        completionHandler(Result.success(results))
                    } catch let e {
                        print(e)
                        completionHandler(Result.failure(.decoding))
                }
                case .failure(let error):
                    completionHandler(Result.failure(.custom(message: "No se ha podido ejecutar el metodo \(method) a \(self.urlServer) por \(error.localizedDescription)")))
            }
        }
    }
    
    
}

