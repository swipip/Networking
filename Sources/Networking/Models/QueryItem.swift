import Foundation

// An object representing an url query item to be injected in a URL construction.
public struct QueryItem: Sendable {
    let key: String
    let value: String

    // Creates a ``QueryItem``
    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
