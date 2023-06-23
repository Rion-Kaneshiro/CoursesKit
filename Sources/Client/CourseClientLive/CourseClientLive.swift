import Dependencies
import Foundation
import SiteRouter
import URLRouting

extension URLRoutingClient: TestDependencyKey where Route == SiteRoute {
  
}

extension URLRoutingClient: DependencyKey where Route == SiteRoute {
  public static var liveValue: URLRoutingClient = .live(router: router.baseURL("http://127.0.0.1:8080"))
}
