
import Foundation
import PerfectHTTP
import PerfectLogger
import PerfectRequestLogger
import PerfectNet

class APIRequestLogger: HTTPRequestFilter {
    
    let randomID: String
    var sequence: UInt32
    
    /// The initializer.
    public init() {
        // Generate random string to prefix request IDs
        randomID = String(randomAlphaNumericLength: 8)
        // Initialize a request count
        sequence = 0
    }
    
    /// Implementation of the HTTPRequestFilter
    func filter(request: HTTPRequest,
                response: HTTPResponse,
                callback: (HTTPRequestFilterResult) -> ()) {
        
        // Store request start time
        request.scratchPad["start"] = getNow()
        
        // Store a unique request ID, this can be used in other logging to correlate to the request log
        sequence += 1
        request.scratchPad["requestID"] = "\(randomID)-\(sequence)"
        
        callback(.continue(request, response))
    }
}

fileprivate func getNow() -> Double {
    
    var posixTime = timeval()
    gettimeofday(&posixTime, nil)
    return Double((posixTime.tv_sec * 1000) + (Int(posixTime.tv_usec)/1000))
}
