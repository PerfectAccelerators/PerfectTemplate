
import Foundation
import PerfectHTTPServer
import PerfectHTTP
import ApplicationConfiguration

protocol RoutesProtocol {
    static func routes() -> Routes
}

extension Application: RoutesProtocol {
    
    static func routes() -> Routes {
        
        var routes = Routes()
        
        // MARK: - Healthcheck
        routes.add(TRoute(method: .get, uri: "/healthcheck", handler: Handlers.healthCheck))
        
        // MARK: - Options
        routes.add(TRoute(method: .options, uri: "/api/v1/**", handler: Handlers.options))
        
        // MARK: - Login - example
        //    routes.add(TRoute<HTTPRequest>(method: .post, uri: "/api/v1/user/login", handler: Handlers.login))
        
        return routes
    }
}
