
import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectCRUD
import PerfectMySQL

protocol AppProtocol {
    
    var name: String { get }
    var config: Configuration? { get}
    var routes: Routes { get }
    var filters: Filters? { get }
    init(name: String, path: String)
    func server() -> HTTPServer.Server
}

struct Filters {
    var request: [(HTTPRequestFilter, HTTPFilterPriority)]?
    var response: [(HTTPResponseFilter, HTTPFilterPriority)]?
}

struct Application: AppProtocol {

    var name: String
    var routes: Routes
    var config: Configuration?
    var filters: Filters?
    
    init(name: String, path: String) {
        self.init(name: name, path: path, routes: nil, filters: nil)
        self.name = name
    }
    
    init(name: String,
         path: String,
         routes: Routes?,
         filters: Filters?) {
        
        self.name = name
        let file = File(path)
        if file.exists == false {
            print("Configuration file doesn't exist!")
        }
        do {
            try file.open(.read, permissions: .readUser)
            defer { file.close() }
            let json = try file.readString()
            let conf = try Configuration(json)
            self.config = conf
        } catch {
            print(error)
        }
        
        if let rts = routes {
            self.routes = rts
        } else {
            self.routes = Application.routes()
        }
        
        if let fltrs = filters {
            self.filters = fltrs
        } else {
            self.filters = Filters(request: Application.requestFilters(),
                                   response: Application.responseFilters())
        }
    }
    
    func server() -> HTTPServer.Server {
        
        let port = config?.server?.port ?? 8181
        let httpServer = HTTPServer.Server.server(name: name,
                                                  port: port,
                                                  routes: routes,
                                                  requestFilters: filters?.request ?? [],
                                                  responseFilters: filters?.response ?? [])

        return httpServer
    }
}

extension Application {
    func database() -> Database<MySQLDatabaseConfiguration>? {
        
        guard let dbConfig = config?.db else {
            return nil
        }
        
        let adapter = DatabaseAdapter(config: dbConfig)
        return adapter.connect()
    }
}
