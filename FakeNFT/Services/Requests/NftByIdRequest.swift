import Foundation

struct NFTRequest: NetworkRequest {
    var httpBody: String?

    let id: String
    
    var endpoint: URL? {
        URL(string: "\(NetworkConstants.baseURL)/api/v1/nft/\(id)")
    }
    var httpMethod: HttpMethod {
        .get
    }
}
