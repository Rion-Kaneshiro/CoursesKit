import Vapor
import VaporRouting
import SiteRouter

enum SiteRouteKey: StorageKey {
  typealias Value = AnyParserPrinter<URLRequestData, SiteRoute>
}

extension Application {
  var router: SiteRouteKey.Value {
    get { storage[SiteRouteKey.self]! }
    set { storage[SiteRouteKey.self] = newValue }
  }
}

// configures your application
public func configure(_ app: Application) async throws {
  // uncomment to serve files from /Public folder
  // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
  
  app.router = router
    .baseURL("http://127.0.0.1:8080")
    .eraseToAnyParserPrinter()
  
  // register routes
  app.mount(app.router, use: siteHandler)
}
