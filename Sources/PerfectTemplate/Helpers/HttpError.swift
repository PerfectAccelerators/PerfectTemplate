
struct HttpError: Error, Codable {
    var code: Int?
    var content: String?
    var message: String?
    var success: Bool?
}

extension HttpError {
    static func defaultError() -> HttpError {
        return HttpError(code: 500,
                         content: "Something went wrong",
                         message: "Internal server error",
                         success: false)
    }
}
