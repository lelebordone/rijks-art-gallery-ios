import XCTest
@testable import RijksArtGallery

class NetworkingTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessfulResponse() {
        // GIVEN
        let service = NetworkServiceMock()
        let expectedData = Data([0, 1, 0, 1])
        let response = HTTPURLResponse(url: URL(fileURLWithPath: service.endpointURLString), // using this init to avoid unnecessary optional values
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
    
    func testClientErrorResponses() {
        // GIVEN
        let expectedStatusCodes = [404, 400, 403]
        let statusCodesResponsesList = expectedStatusCodes.reduce(into: [(statusCode: Int,
                                                                          response: HTTPURLResponse)]()) { partialResult, statusCode in
            guard
                let response = HTTPURLResponse(url: URL(fileURLWithPath: "url"),
                                                 statusCode: statusCode,
                                                 httpVersion: nil,
                                                 headerFields: nil)
            else { return }
            
            partialResult.append((statusCode: statusCode, response: response))
        }
        
        statusCodesResponsesList.forEach { (expectedStatusCode, response) in
            let service = NetworkServiceMock()
            let session = NetworkSessionMock(urlResponse: response)
            let networkConfigurator = NetworkConfigurator(session: session)
            
            
            // Create expectation in order to test async `request` method call
            let expectation = self.expectation(description: "MockNetworkResponse")
            var resultError: NetworkError?
            
            // WHEN
            networkConfigurator.request(service: service) { result in
                guard
                    case let .failure(error) = result
                else { return }
                
                resultError = error
                expectation.fulfill()
            }
            
            // THEN
            
            // Wait for the `expectation` to be fullfilled
            waitForExpectations(timeout: 1)
            
            guard
                let resultError = resultError,
                case let NetworkError.invalidResponse(resultStatusCode) = resultError
            else {
                XCTFail("Expected error != NetworkError.invalidResponse")
                return
            }
            
            XCTAssertEqual(resultStatusCode, expectedStatusCode)
        }
    }
}
