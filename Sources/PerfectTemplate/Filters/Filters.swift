
import PerfectHTTPServer
import PerfectHTTP
import PerfectRequestLogger

extension Application {
    static func requestFilters() -> [(HTTPRequestFilter, HTTPFilterPriority)] {
        
        var filters: [(HTTPRequestFilter, HTTPFilterPriority)] = [(HTTPRequestFilter, HTTPFilterPriority)]()
        filters.append((APIRequestLogger(), HTTPFilterPriority.high))
        filters.append((APIRequestFilter(), HTTPFilterPriority.high))
        
        return filters
    }
    
    static func responseFilters() -> [(HTTPResponseFilter, HTTPFilterPriority)] {
        
        var filters: [(HTTPResponseFilter, HTTPFilterPriority)] = [(HTTPResponseFilter, HTTPFilterPriority)]()
        
        do {
            let contentCompressionFilter = try PerfectHTTPServer.HTTPFilter.contentCompression(data: [:])
            filters.append((contentCompressionFilter, HTTPFilterPriority.high))
        } catch {
            print("Content compression filter problem")
        }

        filters.append((APIResponseLogger(), HTTPFilterPriority.low))
        filters.append((APIResponseFilter(), HTTPFilterPriority.medium))
        
        return filters
    }
}
