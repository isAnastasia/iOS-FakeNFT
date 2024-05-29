import Foundation

struct NFTRequest: NetworkRequest {
    
    var httpMethod: HttpMethod = .get
    
    var dto: Encodable?
    
    var httpBody: String?

    let id: String

    var endpoint: URL? {
//        URL(string: "\(RequestConstants.baseURL)/api/v1/nft/\(id)")
        URL(string: "\(NetworkConstants.baseURL)/api/v1/nft/\(id)")
    }
}
