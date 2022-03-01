import Foundation

enum NetworkError: Error {
    case generic(Error)
    case invalidEndpoint
    case invalidResponse(statusCode: Int? = nil)
    case noData
    case decoding
    case noMorePages
    case maxRetriesReached
    
    var userFacingError: UserFacingError? {
        switch self {
        case .generic(let error):
            return UserFacingError(message: "An unexpected error has occurred",
                                   description: error.localizedDescription)
        case .invalidResponse, .noData, .invalidEndpoint:
            return UserFacingError(message: "Service unavailable",
                                   description: "The service seems to be unavailable. Please try again later.")
        case .decoding:
            return UserFacingError(message: "An unexpected error has occurred",
                                   description: "There was an unexpected error during your request. We apologize for the inconvenient.")
        case .maxRetriesReached:
            return UserFacingError(message: "Service unavailable",
                                   description: "There seems to be some problems on our end. Please come back later.")
        default:
            return nil
        }
    }
}

struct UserFacingError: Error {
    var message, description: String
}
