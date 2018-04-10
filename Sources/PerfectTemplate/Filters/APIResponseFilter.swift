
import PerfectHTTP
import PerfectLogger
import Dispatch
import PerfectLib
import Foundation

struct APIResponseFilter: HTTPResponseFilter {
    
    /// Called once before headers are sent to the client.
    public func filterHeaders(response: HTTPResponse,
                              callback: (HTTPResponseFilterResult) -> ()) {
        
        response.addHeader(.strictTransportSecurity, value: "max-age=31536000; includeSubDomains")
        response.addHeader(.xFrameOptions, value: "DENY")
        
        callback(.continue)
    }
    
    /// Called zero or more times for each bit of body data which is sent to the client.
    public func filterBody(response: HTTPResponse,
                           callback: (HTTPResponseFilterResult) -> ()) {
        
        callback(.continue)
    }
}
