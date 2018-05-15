
import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import ScantORM
import PerfectMySQL
import PerfectCRUD
import ApplicationConfiguration

extension Application: AppDatabaseProtocol {
    
    public func database() -> Database<MySQLDatabaseConfiguration>? {
        guard let dbConfig = config?.db else {
            return nil
        }
        let adapter = DatabaseAdapter<MySQLDatabaseConfiguration>(config: dbConfig)
        return adapter.connect()
    }
    
    public func disconnect() {
        // Todo
    }
}
