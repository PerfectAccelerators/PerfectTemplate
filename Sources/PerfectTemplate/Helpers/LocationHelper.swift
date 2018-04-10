
import Foundation
import PerfectHTTP

struct LocationHelper {
    static func extractCFHeaders(_ response: HTTPResponse) -> (ip: String, country: String, ray: String, xforward: String)? {
        
        guard let cfConnectingIp = response.request.header(HTTPRequestHeader.Name.custom(name: "CF-Connecting-IP")) else {
            return nil
        }
        
        guard let cfIPCountry = response.request.header(HTTPRequestHeader.Name.custom(name: "CF-IPCountry")) else {
            return nil
        }
        
        guard let cfRAY = response.request.header(HTTPRequestHeader.Name.custom(name: "CF-RAY")) else {
            return nil
        }
        
        guard let cfXForwardedFor = response.request.header(HTTPRequestHeader.Name.custom(name: "X-Forwarded-For")) else {
            return nil
        }
        
        return (cfConnectingIp, cfIPCountry, cfRAY, cfXForwardedFor)
    }
    
    static func extractCFHeaders(_ request: HTTPRequest) -> (ip: String, country: String, ray: String, xforward: String)? {
        
        guard let cfConnectingIp = request.header(HTTPRequestHeader.Name.custom(name: "CF-Connecting-IP")) else {
            return nil
        }
        
        guard let cfIPCountry = request.header(HTTPRequestHeader.Name.custom(name: "CF-IPCountry")) else {
            return nil
        }
        
        guard let cfRAY = request.header(HTTPRequestHeader.Name.custom(name: "CF-RAY")) else {
            return nil
        }
        
        guard let cfXForwardedFor = request.header(HTTPRequestHeader.Name.custom(name: "X-Forwarded-For")) else {
            return nil
        }
        
        return (cfConnectingIp, cfIPCountry, cfRAY, cfXForwardedFor)
    }
}

