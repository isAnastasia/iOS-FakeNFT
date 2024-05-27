import Foundation

struct NFTRequest: NetworkRequest {

    let id: String

    var endpoint: URL? {
//        URL(string: "\(RequestConstants.baseURL)/api/v1/nft/\(id)")
        URL(string: "\(NetworkConstants.baseURL)/api/v1/nft/\(id)")
    }
}
