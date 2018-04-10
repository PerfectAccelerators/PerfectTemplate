
import Foundation
import PerfectLogger
import PerfectHTTP

struct Logger {
    
    static func log(_ type: LogType, _ message: String,  _ response: HTTPResponse? = nil) {
        
        var headers: String? = nil
        if let resp = response {
            if let (ip, country, ray, xforward) = LocationHelper.extractCFHeaders(resp) {
                headers = "ip: \(ip), country: \(country), ray: \(ray), xforward: \(xforward)"
            }
        }
        
        switch type {
        case .debug:
            guard let hdrs = headers else {
                LogFile.debug("\(message)")
                return
            }
            LogFile.debug("headers: \(hdrs) - \(message)")
            
        case .error:
            guard let hdrs = headers else {
                LogFile.error("\(message)")
                return
            }
            LogFile.error("headers: \(hdrs) - \(message)")
        case .critical:
            guard let hdrs = headers else {
                LogFile.critical("\(message)")
                return
            }
            LogFile.critical("headers: \(hdrs) - \(message)")
        }
    }
}

enum LogType {
    case debug
    case error
    case critical
}

