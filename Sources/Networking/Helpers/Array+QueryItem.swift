import Foundation

public extension Array where Element == QueryItem {
    var urlQueryItems: [URLQueryItem] {
        self.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
