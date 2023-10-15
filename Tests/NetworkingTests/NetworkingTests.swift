import XCTest
@testable import Networking

final class NetworkingTests: XCTestCase {

    func testUrlConstruction() {

        struct TestEnpoint: Endpoint {
            typealias Model = String

            var host: String = "test.com"
            var path: String = "user"
            var queryParams: [QueryItem] = []
        }

        struct TestEndpointTwo: Endpoint {
            typealias Model = String

            var host: String = "test.fr"
            var path: String = ""
            var queryParams: [QueryItem] = [
                .init(key: "key1", value: "value1"),
                .init(key: "key2", value: "value2")
            ]
        }

        let endpoint1 = TestEnpoint()
        XCTAssertEqual(endpoint1.url?.absoluteString, "https://test.com/user")

        let endpoint2 = TestEndpointTwo()
        XCTAssertEqual(endpoint2.url?.absoluteString, "https://test.fr/?key1=value1&key2=value2")
    }

}
