import Dependencies
import Foundation
import Model
import SiteRouter
import URLRouting

extension URLRoutingClient: TestDependencyKey where Route == SiteRoute {
  public static var testValue: URLRoutingClient = .failing
}

extension DependencyValues {
  public var apiClient: URLRoutingClient<SiteRoute> {
    get { self[URLRoutingClient.self] }
    set { self[URLRoutingClient.self] = newValue }
  }
}
