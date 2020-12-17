<p align="center">
<img src="https://i.imgur.com/7M3CvDR.png)"/></p>

# NBApollo

NBApollo: A wrapper library around Alamofire HTTP Network with codable objects.

- [Features](#features)
- [Component Libraries](#component-libraries)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Features

- [x] HTTP Response Validation
- [x] HTTP Request / Response Methods
- [x] JSON Codable compatible objects to return

## Component Libraries

NBApollo use ```Alamofire``` to make request. 

## Requirements

- iOS 10.0+
- Xcode 11+
- Swift 4.2+

## Installation

### CocoaPods

NBApollo is not on cocoapods yet, but you could install using Pod.

```ruby
  pod 'NBApollo', :git => 'https://github.com/josmanperez/NBApollo.git', :tag => '0.1.7'
```

## Usage

If you API returns a object, something like this:

```json
{
 "id":"1234",
 "valid": true
}
 ```

Then you need to create a ```Codable``` object like this:

```swift
class Data: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case valid
    }
    
    var id: String
    var valid: Bool
}
```

When you need to call your api to gather a JSON object (conforms Codable), just need to call

```swift
let apiRequest: ApiRestClient<Data> = {
    let api = ApiRestClient<Data>(urlServer: "api endpoint")
    return api
}()
```

When you need to call this method:

```swift
self.nodoRequest.request(with: headers, method: .get, parameters: nil) { 
	result in 

    case .failure(let error):
        ...

    case .success(let response):
        print(response)
}

```

## License

NBApollo is released under the MIT license. 
