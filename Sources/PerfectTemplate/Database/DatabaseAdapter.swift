//
//  DBConnection.swift
//  BS
//
//  Created by Fatih Nayebi on 2018-04-09.
//

import PerfectMySQL
import PerfectCRUD

protocol DatabaseAdapterProtocol {
    var dbConfig: DBConfiguration { get }
    init(config: DBConfiguration)
}

protocol DatabaseConnectionProtocol {
    associatedtype DBConfigurationProtocol: DatabaseConfigurationProtocol
    func connect() -> Database<DBConfigurationProtocol>?
    func disconnect()
}

struct DatabaseAdapter: DatabaseAdapterProtocol {
    
    var dbConfig: DBConfiguration
    
    init(config: DBConfiguration) {
        dbConfig = DBConfiguration(name: config.name,
                                   host: config.host,
                                   port: config.port,
                                   user: config.user,
                                   pass: config.pass,
                                   driverType: config.driverType)
    }
}

extension DatabaseAdapter: DatabaseConnectionProtocol {
    typealias DBConfigurationProtocol = MySQLDatabaseConfiguration
    func connect() -> Database<DBConfigurationProtocol>? {
        do {
            let connection = try DBConfigurationProtocol(database: dbConfig.name ?? "perfect",
                                                         host: dbConfig.host ?? "localhost",
                                                         port: dbConfig.port ?? 3306,
                                                         username: dbConfig.user,
                                                         password: dbConfig.pass)
            return Database(configuration: connection)
        } catch let error {
            print("\(error)")
            return nil
        }
    }
    
    func disconnect() {
        // Todo
    }
}
