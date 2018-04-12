
import Foundation
import PerfectHTTP
import PerfectLogger
import PerfectRequestLogger
import SwiftMoment
import PerfectNet

class APIResponseLogger: HTTPResponseFilter {
    
    func filterHeaders(response: HTTPResponse,
                       callback: (HTTPResponseFilterResult) -> ()) {
        
        let hostname = response.request.serverName
        let requestID = response.request.scratchPad["requestID"] as? String ?? "NoRequestID"
        let method = response.request.method
        let requestURL = response.request.uri
        let remoteAddress = response.request.remoteAddress.host
        let start = response.request.scratchPad["start"] as? Double ?? getNow()
        let protocolVersion = response.request.protocolVersion
        let status = response.status.code
        let length = response.bodyBytes.count
        let requestProtocol = response.request.connection is PerfectNet.NetTCPSSL ? "HTTPS" : "HTTP"
        
        let interval = Int(getNow() - start)
        let started = moment(start/1000)
        
        var useFile = RequestLogFile.location
        if useFile.isEmpty { useFile = "/var/log/perfectLog.log" }
        
        var logMessage = "[\(hostname)/\(requestID)] \(started) - "
        logMessage.append("[from: \(remoteAddress) - \(status) \(length)B in \(interval)ms] \n")
        logMessage.append("[\(method) \(requestURL) \(requestProtocol)/\(protocolVersion.0).\(protocolVersion.1)]")
        
        LogFile.info(logMessage, logFile: useFile)
        
        callback(.continue)
    }
    
    /// Implementation of the HTTPResponseFilter
    func filterBody(response: HTTPResponse,
                    callback: (HTTPResponseFilterResult) -> ()) {
        callback(.continue)
    }
}

fileprivate func getNow() -> Double {
    
    var posixTime = timeval()
    gettimeofday(&posixTime, nil)
    return Double((posixTime.tv_sec * 1000) + (Int(posixTime.tv_usec)/1000))
}
