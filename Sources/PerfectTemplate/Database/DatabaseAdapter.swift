//
//  DBConnection.swift
//  BS
//
//  Created by Fatih Nayebi on 2018-04-09.
//

import PerfectMySQL
import PerfectCRUD

struct DatabaseAdapter {
    let dbConfig: DBConfiguration
    init(config: DBConfiguration) {
        dbConfig = DBConfiguration(name: config.name,
                                   host: config.host,
                                   port: config.port,
                                   user: config.user,
                                   pass: config.pass)
    }
    
    func connect() -> Database<MySQLDatabaseConfiguration>? {
        let mySQL = MySQL()
        let connected = mySQL.connect(host: dbConfig.host,
                                      user: dbConfig.user,
                                      password: dbConfig.pass,
                                      db: dbConfig.name,
                                      port: dbConfig.port ?? 3306,
                                      socket: nil,
                                      flag: 0)
        
        guard connected else {
            print(mySQL.errorMessage())
            return nil
        }
        
        let db = Database(configuration: MySQLDatabaseConfiguration(connection: mySQL))
        return db
    }
}
