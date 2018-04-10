
import PerfectHTTP
import PerfectLogger
import Dispatch
import PerfectLib
import Foundation

struct APIRequestFilter: HTTPRequestFilter {
    
    public func filter(request: HTTPRequest,
                       response: HTTPResponse,
                       callback: (HTTPRequestFilterResult) -> ()) {
        
        if request.method == .post {
            if let postBody = request.postBodyString, !postBody.isEmpty {
                if postBody.contains(string: "<script") {
                    
                    _ = try? response.setBody(json: ["msg":"Internal server error"])
                    response.status = HTTPResponseStatus.statusFrom(code: 500)
                    response.addHeader(.contentType, value: "application/json")

                    response.completed()
                    
                    Logger.log(.critical, "post body string containes javascript!", response)
                }
            } else {
                _ = try? response.setBody(json: ["msg": "Incomplete request"])
                response.status = HTTPResponseStatus.statusFrom(code: 400)
                response.addHeader(.contentType, value: "application/json")
                response.completed()
            }
        }
        
        callback(HTTPRequestFilterResult.continue(request, response))
    }
}
