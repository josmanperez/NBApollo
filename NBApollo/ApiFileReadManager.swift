//
//  ApiFileReadManager.swift
//  NBApollo
//
//  Created by Josman Pérez Expósito on 05/04/2020.
//  Copyright © 2020 Josman Pérez Expósito. All rights reserved.
//

import Foundation


//enum Configuration: String, ApiRawValueProtocol {
//    case apiConfiguration = "ApiConfiguration"
//    case plist
//
//    func get() -> String {
//        return self.rawValue
//    }
//}

public protocol ApiRawValueProtocol {
    func get() -> String
}

/// Las claves de nuestro properties list deben cumplir este protocolo.
public protocol Configuration: ApiRawValueProtocol {
    var plist: String { get set }
    var apiConfigNameFile: String { get set }
    
    func get() -> String
}

/// Handle the FileReadManager errors with a description
struct FileReadManagerError: Error {
    
    enum ErrorKind: Error {
        case pathNotFound
        case infoPlistMalformed
        case keyNotFound
        case cantReadInfoPlistFile
    }
    
    let description: String
    let kind: ErrorKind
}

/// Class for reading property list object
/// For retrieving Api Keys
public class FileReadManager {
    
    public static var shared: FileReadManager {
        if let initializedShared = _shared {
            return initializedShared
        } else {
            print("Singleton not yet initialized. Run setup(withConfig:) first")
            return FileReadManager(withConfig: Configuration.self as! Configuration)
        }
    }
    
    private static var _shared: FileReadManager?
    private var config: Configuration
    
    public func setup(withConfig config: Configuration) {
        FileReadManager._shared = FileReadManager(withConfig: config)
    }
    
    private init(withConfig config: Configuration) {
        self.config = config
    }
    
    /// Function to retrieve api keys to used them in the rest api requests
    /// - Returns: Optional string with api key for request based on key
    /// - Parameters: key `ApiKey` to retrieve value
    /// - Throws: pathNotFound, infoPlistNotFound and keyNotFound
    public func getApiValue<T: ApiRawValueProtocol>(with key: T) throws -> String {
        guard let pathToInfoPlist = Bundle.main.path(forResource: config.apiConfigNameFile, ofType: config.plist) else {
            throw FileReadManagerError(description: "The resource \(config.apiConfigNameFile) has not been found on the main bundle path", kind: .pathNotFound)
        }
        guard let apiDictionary = NSDictionary(contentsOfFile: pathToInfoPlist) else {
            throw FileReadManagerError(description: "There is no dictionary asociated to the \(config.apiConfigNameFile) plist file", kind: .infoPlistMalformed)
        }
        guard let _key = apiDictionary[key.get()] as? String else {
            throw FileReadManagerError(description: "The key \(key.get()) is not found on the \(config.apiConfigNameFile) dictionary", kind: .keyNotFound)
        }
        return _key
    }
    
    /// Function to retrieve api keys dictionary to used them in the rest api requests
    /// - Returns: Dictionary of string with api, key
    /// - Parameters: key `ApiKey` to retrieve value
    /// - Throws: pathNotFound, infoPlistNotFound and keyNotFound
    public func getApiDictionary<T: ApiRawValueProtocol>(with key: T) throws -> NSDictionary {
        guard let pathToInfoPlist = Bundle.main.path(forResource: config.apiConfigNameFile, ofType: config.plist) else {
            throw FileReadManagerError(description: "The resource \(config.apiConfigNameFile) has not been found on the main bundle path", kind: .pathNotFound)
        }
        guard let apiDictionary = NSDictionary(contentsOfFile: pathToInfoPlist) else {
            throw FileReadManagerError(description: "There is no dictionary asociated to the \(config.apiConfigNameFile) plist file", kind: .infoPlistMalformed)
        }
        guard let _key = apiDictionary[key.get()] as? NSDictionary else {
            throw FileReadManagerError(description: "The key \(key.get()) is not found on the \(config.apiConfigNameFile) dictionary", kind: .keyNotFound)
        }
        return _key
    }
}
