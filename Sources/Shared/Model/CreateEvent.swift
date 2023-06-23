import Foundation

public struct CreateEvent: Codable, Equatable {
  public let date: Date
  
  public init(date: Date) {
    self.date = date
  }
}
