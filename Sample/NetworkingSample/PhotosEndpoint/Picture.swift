import Foundation

struct Picture: Decodable {
    let id: String
    let urls: Urls
}

struct Urls: Decodable {
    let full: String
    let regular: String
    let small: String
}
