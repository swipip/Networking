import Foundation

/// A protocol describing how ``NetworkingManager`` should handle the networking request.
///
/// Exemple implementation:
/// ```swift
/// struct Users: Endpoint {
///     typealias: Model = User // Where user conforms to Decodable
///
///     var host: String = "app.sample.domain.com"
///     var path: String = "/users"
///     var queryItem: [QueryItem] = [.init(key: "limit", value: "10")
/// }
/// ```
/// The actual url is constructed in ``Endpoint.url``.
///
public protocol Endpoint {
    associatedtype Model: Decodable

    var host: String { get }
    var path: String { get }
    var queryParams: [QueryItem] { get }

    var url: URL? { get }
}

public extension Endpoint {
    var url: URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = host
        component.path = "/" + path

        if !queryParams.isEmpty {
            component.queryItems = queryParams.urlQueryItems
        }

        return component.url
    }
}

extension Endpoint {
    func describe() -> String {
        "\(host) \(path) \(queryParams.map { "\($0.key)=" + "\($0.value)" })"
    }
}
