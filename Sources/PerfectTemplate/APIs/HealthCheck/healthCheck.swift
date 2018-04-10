
import Foundation
import PerfectHTTP

extension Handlers {
    // Used for healthcheck functionality for monitors and load balancers.
    // Do not remove unless you have an alternate plan
    static func healthCheck(request: HTTPRequest) throws -> HealthCheckResponse {
        return .init(health: "OK")
    }
}
