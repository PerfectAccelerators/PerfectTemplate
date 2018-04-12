
import Foundation
import PerfectHTTP

extension Handlers {
    
    static func options(request: HTTPRequest) throws -> OptionsResponse {
        return .init(options: "OK")
    }
}
