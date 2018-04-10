
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

#if os(Linux)
let fileRoot = "/perfect-deployed/Perfect/"
let filePath = "./config/ApplicationConfigurationLinux.json"
#else
let fileRoot = ""
let filePath = "./config/ApplicationConfiguration.json"
#endif

let app = Application(name: "Perfect", path: filePath)
guard let db = app.database() else {
    fatalError("Not able to connect to DB")
}

let database = DatabaseManager(db: db)
do {
    try database.create(Person.self, pk: \.id)
    try HTTPServer.launch(app.server())
} catch {
    fatalError("\(error)")
}
