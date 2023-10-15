import Foundation

/// An enum describing possible error that might occur when using ``NetworkingManager``
public enum NetworkingError: Error {
    case endpointMalformed
    case decodingError(associatedError: Error)
}

public protocol NetworkingLayer {
    func call<T: Endpoint>(_ endpoint: T) async throws -> T.Model
}

/// A networking layer allowing you to make quick implementation of ``Endpoint``s sparing you
/// the hassle of implementing URLSession yourself.
///
/// NetworkingManger implements the public protocol ``NetworkingLayer``.
public struct NetworkingManager: NetworkingLayer {

    private typealias Response = (data: Data, response: URLResponse)

    private let urlSession: URLSession

    /// Creates an instance of NetworkingManager.
    public init() {
        self.urlSession = .shared
    }

    internal init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    /// Cell this method passing a endpoint conforming to ``Endpoint`` to retrieve the associated model.
    ///
    /// This method is a high level wrapper of URLSession.
    ///
    /// - Parameters:
    ///     - endpoint: An object implementing ``Endpoint``
    ///
    /// - Returns: Then endpoint's associated Model.
    public func call<T: Endpoint>(_ endpoint: T) async throws -> T.Model {
        guard let url = endpoint.url else {
            throw NetworkingError.endpointMalformed
        }

        let result: Response = try await urlSession.data(from: url)

        do {
            return try JSONDecoder().decode(T.Model.self, from: result.data)
        } catch {
            throw NetworkingError.decodingError(associatedError: error)
        }
    }

}
