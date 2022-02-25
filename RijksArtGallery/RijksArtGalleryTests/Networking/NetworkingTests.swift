import XCTest
@testable import RijksArtGallery

class NetworkingTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessfulResponse() throws {
        // GIVEN
        let service = NetworkServiceMock()
        let expectedData = Data([0, 1, 0, 1])
        let response = HTTPURLResponse(url: URL(fileURLWithPath: service.endpointURLString),
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        let session = NetworkSessionMock(data: expectedData, urlResponse: response)
        let networkConfigurator = NetworkConfigurator(session: session)
        
        // Create expectation in order to test async `request` method call
        let expectation = self.expectation(description: "MockNetworkResponse")
        var resultData: Data?
        
        // WHEN
        networkConfigurator.request(service: service) { result in
            guard case let .success(data) = result else { return }
            
            resultData = data
            expectation.fulfill()
        }
        
        // THEN
        
        // Wait for the `expectation` to be fullfilled
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(resultData, expectedData)
    }
}
