
import PerfectHTTP
import PerfectThread
import Foundation
import PerfectLogger

typealias APIPromise<T: Codable> = Promise<HTTPResponseContent<APIResult<T>>>

extension Handlers {
    
    // MARK: - json
    
    static func json<T>(_ request: HTTPRequest,
                        _ promise: APIPromise<T>,
                        _ result: APIResult<T>) {
        
        let status = HTTPResponseStatus.statusFrom(code: result.code ?? 200)
        let apiResponse = HTTPResponseContent<APIResult<T>>(status: status,
                                                            body: result)
        promise.set(apiResponse)
    }
    
    // MARK: - error
    
    static func error<T>(_ request: HTTPRequest,
                         _ promise: APIPromise<T>,
                         message: String?,
                         userFriendlyMessage: String?,
                         code: Int? = 400,
                         success: Bool? = false) {
        
        let apiResult = APIResult<T>(message: message,
                                     userFriendlyMessage: userFriendlyMessage,
                                     code: code,
                                     success: false)
        
        let status = HTTPResponseStatus.statusFrom(code: code ?? 400)
        let apiResponse = HTTPResponseContent<APIResult<T>>(status: status,
                                                            body: apiResult)
        promise.set(apiResponse)
    }
    
    // MARK: - incomplete request
    
    /// incomplete request
    /// returns the APIResult to be used in handlers
    static func incompleteRequest<T>(_ userFriendlyMessage: String? = nil) -> APIResult<T> {
        
        let apiMessage = userFriendlyMessage ?? "Incomplete request data"
        let result: APIResult<T> = APIResult(message: "Something went wrong",
                                             userFriendlyMessage: apiMessage,
                                             code: 400,
                                             success: false)
        
        return result
    }
    
    /// incomplete request
    /// sets the promise for the handler
    static func incompleteRequest<T>(_ promise: APIPromise<T>,
                                     _ userFriendlyMessage: String? = nil)  {
        
        let apiMessage = userFriendlyMessage ?? "Incomplete request data"
        let result: APIResult<T> = APIResult(message: "Something went wrong",
                                             userFriendlyMessage: apiMessage,
                                             code: 400,
                                             success: false)
        
        let response = HTTPResponseContent<APIResult<T>>(status: .badRequest,
                                                         body: result)
        promise.set(response)
        
    }
    
    // MARK: - internal server error
    
    /// internal server error
    /// returns the APIResult to be used in handlers
    static func internalServerError<T>(_ message: String? = nil) -> APIResult<T> {
        
        let apiMessage = message ?? "Internal server error"
        let result: APIResult<T> = APIResult(message: "Something went wrong",
                                             userFriendlyMessage: apiMessage,
                                             code: 500,
                                             success: false)
        
        return result
    }
    
    /// internal server error
    /// sets the promise for the handler
    static func internalServerError<T>(_ promise: APIPromise<T>,
                                       _ message: String? = nil)  {
        
        let apiMessage = message ?? "Internal server error"
        let result: APIResult<T> = APIResult(message: "Something went wrong",
                                             userFriendlyMessage: apiMessage,
                                             code: 500,
                                             success: false)
        let response = HTTPResponseContent<APIResult<T>>(status: .internalServerError,
                                                         body: result)
        promise.set(response)
    }
    
    // MARK: - Authorization
    
    /// app is not identified
    static func appIsNotIdentified<T>(_ promise: APIPromise<T>) {
        
        let result = APIResult<T>(message: "Application is not identified",
                                  userFriendlyMessage: "",
                                  code: 403,
                                  success: false)
        let response = HTTPResponseContent<APIResult<T>>(status: .forbidden,
                                                         body: result)
        promise.set(response)
    }
}
