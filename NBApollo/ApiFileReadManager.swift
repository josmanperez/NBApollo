import Foundation

public protocol ApiRawValueProtocol {
    var apiConfiguration:String { get }
    var plist:String { get }
}

extension String: ApiRawValueProtocol {
    public var apiConfiguration: String {
        return "apiConfiguration"
    }
    
    public var plist: String {
        return "plist"
    }
}

/// Handle the FileReadManager errors with a description
struct FileReadManagerError: Error {
    
    enum ErrorKind: Error {
        case pathNotFound
        case infoPlistMalformed
        case keyNotFound
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
            return FileReadManager(withConfig: ApiRawValueProtocol.self as! ApiRawValueProtocol)
        }
    }
    
    private static var _shared: FileReadManager?
    private var config: ApiRawValueProtocol
    
    public func setup(withConfig config: ApiRawValueProtocol) {
        FileReadManager._shared = FileReadManager(withConfig: config)
    }
    
    private init(withConfig config: ApiRawValueProtocol) {
        self.config = config
    }
    /// Function to retrieve api keys to used them in the rest api requests
    /// - Returns: Optional string with api key for request based on key
    /// - Parameters: key `ApiKey` to retrieve value
    /// - Throws: pathNotFound, infoPlistNotFound and keyNotFound
    public func getApiValue<T: ApiRawValueProtocol>(with key: T) throws -> String {
        guard let pathToInfoPlist = Bundle.main.path(forResource: config.apiConfiguration, ofType: config.plist) else {
            throw FileReadManagerError(description: "The resource \(config.apiConfiguration) has not been found on the main bundle path", kind: .pathNotFound)
        }
        guard let apiDictionary = NSDictionary(contentsOfFile: pathToInfoPlist) else {
            throw FileReadManagerError(description: "There is no dictionary asociated to the \(config.apiConfiguration) plist file", kind: .infoPlistMalformed)
        }
        guard let _key = apiDictionary[key] as? String else {
            throw FileReadManagerError(description: "The key \(key) is not found on the \(config.apiConfiguration) dictionary", kind: .keyNotFound)
        }
        return _key
    }
    
    /// Function to retrieve api keys to used them in the rest api requests
    /// - Returns: Dictionary of string with api, key
    /// - Parameters: key `ApiKey` to retrieve value
    /// - Throws: pathNotFound, infoPlistNotFound and keyNotFound
    public func getApiDictionary<T: ApiRawValueProtocol>(with key: T) throws -> NSDictionary {
        guard let pathToInfoPlist = Bundle.main.path(forResource: config.apiConfiguration, ofType: config.plist) else {
            throw FileReadManagerError(description: "The resource \(config.apiConfiguration) has not been found on the main bundle path", kind: .pathNotFound)
        }
        guard let apiDictionary = NSDictionary(contentsOfFile: pathToInfoPlist) else {
            throw FileReadManagerError(description: "There is no dictionary asociated to the \(config.apiConfiguration) plist file", kind: .infoPlistMalformed)
        }
        guard let _key = apiDictionary[key] as? NSDictionary else {
            throw FileReadManagerError(description: "The key \(key) is not found on the \(config.apiConfiguration) dictionary", kind: .keyNotFound)
        }
        return _key
    }
}

