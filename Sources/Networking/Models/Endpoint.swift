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

    /// The model to decode the retrieved data into.
    associatedtype Model: Decodable

    /// The url host.
    var host: String { get }

    /// The url path.
    var path: String { get }

    /// The query items to add the url.
    var queryParams: [QueryItem] { get }

    /// The actual URL formed from other properties.
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
