
import Foundation

struct PhoneNumber: Codable {
    let id: UUID
    let personId: UUID
    let planetCode: Int
    let number: String
}

struct Person: Codable {
    let id: UUID
    let firstName: String
    let lastName: String
    let phoneNumbers: [PhoneNumber]?
}
