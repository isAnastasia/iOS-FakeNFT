import Foundation

struct ExampleRequest: NetworkRequest {
    var httpBody: String?
    
    var endpoint: URL? {
        URL(string: "INSERT_URL_HERE")
    }
}
