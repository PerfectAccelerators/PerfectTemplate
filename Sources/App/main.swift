
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import Lib
import ApplicationConfiguration

#if os(Linux)
let fileRoot = "/perfect-deployed/Perfect/"
let filePath = "./config/ApplicationConfigurationLinux.json"
#else
let fileRoot = ""
let filePath = "./config/ApplicationConfiguration.json"
#endif

let app = Application(name: "Perfect",
                      path: filePath,
                      routes: Application.appRoutes(),
                      filters: AppFilters(request: Application.requestFilters(),
                                          response: Application.responseFilters()))

do {
    try HTTPServer.launch(app.server())
} catch {
    fatalError("\(error)")
}
