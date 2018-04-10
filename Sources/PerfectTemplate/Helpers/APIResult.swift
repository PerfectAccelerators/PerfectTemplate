
import Foundation

class APIResult<T: Codable>: Codable {
    var message: String?
    var userFriendlyMessage: String?
    var code: Int?
    var success: Bool?
    var result: T?
    
    init(message: String?,
         userFriendlyMessage: String?,
         code: Int?,
         success: Bool?,
         result: T? = nil) {
        self.message = message
        self.userFriendlyMessage = userFriendlyMessage
        self.code = code
        self.success = success
        if result != nil {
            self.result = result
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case message
        case userFriendlyMessage
        case code
        case success
        case result
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decode(String.self, forKey: .message)
        self.userFriendlyMessage = try container.decode(String.self, forKey: .userFriendlyMessage)
        self.code = try container.decode(Int.self, forKey: .code)
        self.success = try container.decode(Bool.self, forKey: .success)
        self.result = try container.decode(T.self, forKey: .result)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(message, forKey: .message)
        try container.encode(userFriendlyMessage, forKey: .userFriendlyMessage)
        try container.encode(code, forKey: .code)
        try container.encode(success, forKey: .success)
        try container.encode(result, forKey: .result)
    }
}

struct NoResult: Codable {
    var message: String = ""
}
