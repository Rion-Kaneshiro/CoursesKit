import Foundation

public struct Event: Codable, Equatable, Identifiable {
  public let id: UUID
  public let courseId: Course.ID
  public let date: TimeInterval
  public let enrolled: Bool
  
  public init(id: UUID, courseId: Course.ID, date: TimeInterval, enrolled: Bool) {
    self.id = id
    self.courseId = courseId
    self.date = date
    self.enrolled = enrolled
  }
}
