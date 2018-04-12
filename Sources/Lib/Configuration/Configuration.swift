
import Foundation

struct Configuration: Codable {
    let server: ServerConfiguration?
    let logging: LoggingConfiguration?
    let db: DBConfiguration?
    let ssl: SSLConfiguration?
    let os: OS?
    let environment: Environment?
}

struct ServerConfiguration: Codable {
    let baseURL: String?
    let baseDomain: String?
    let port: Int?
    let secure: Int?
}

struct LoggingConfiguration: Codable {
    let requestLoggingPath: String?
    let logPath: String?
}

struct DBConfiguration: Codable {
    let name: String?
    let host: String?
    let port: Int?
    let user: String?
    let pass: String?
    let driverType: DBDriverType
}

enum DBDriverType: Int, Codable {
    case MySQL = 1
    case PostgreSQL = 2
}

struct SSLConfiguration: Codable {
    let port: Int?
    let originCertificatePath: String?
    let privateKeyPath: String?
    let verifyMode: String?
}

enum OS: Int, Codable {
    case linux = 1
    case macOS = 2
}

enum Environment: Int, Codable {
    case dev = 1
    case preProd = 2
    case prod = 3
}

// MARK: Convenience initializers

extension Configuration {
    
    init(data: Data) throws {
        self = try JSONDecoder().decode(Configuration.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
