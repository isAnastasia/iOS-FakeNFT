import Foundation

struct ExampleRequest: NetworkRequest {
    
    var httpMethod: HttpMethod = .get
    
    var dto: Encodable?
    
    var httpBody: String?
    
    var endpoint: URL? {
        URL(string: "INSERT_URL_HERE")
    }
}
