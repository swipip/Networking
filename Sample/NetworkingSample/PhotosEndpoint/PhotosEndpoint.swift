import Foundation
import Networking

struct PhotosEndpoint: Endpoint {
    typealias Model = Picture

    var host: String
    var path: String
    var queryParams: [Networking.QueryItem]
}
