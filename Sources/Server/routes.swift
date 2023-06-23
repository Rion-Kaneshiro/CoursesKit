import Dependencies
import Model
import Vapor
import SiteRouter

extension Course: Content {}
extension Tutor: Content {}
extension Event: Content {}
extension CreateEvent: Content {}

actor Database {
  @Dependency(\.uuid) private var uuid
  
  var availableCourses: [Course] = Course.initialData
  var events: [Course.ID: [Event]] = [:]
  
  func createEvent(courseId: Course.ID, date: Date) async throws -> [Event] {
    // TODO: Check if an event at that date does already exist
    
    let event = Event(id: uuid(), courseId: courseId, date: date.timeIntervalSince1970, enrolled: false)
    
    var currentEvents = events[courseId] ?? []
    
    currentEvents.append(event)
    
    events[courseId] = currentEvents
    
    return currentEvents
  }
}

let database = Database()

func siteHandler(
  request: Request,
  route: SiteRoute
) async throws -> AsyncResponseEncodable {
  switch route {
  case let .courses(coursesRoute):
    return try await coursesHandler(request: request, route: coursesRoute)
  }
}

func coursesHandler(
  request: Request,
  route: CoursesRoute
) async throws -> AsyncResponseEncodable {
  switch route {
  case .fetch:
    return await database.availableCourses
  case let .course(id, eventsRoute):
    return try await eventsHandler(courseId: id, request: request, route: eventsRoute)
  }
}

func eventsHandler(
  courseId: Course.ID,
  request: Request,
  route: EventsRoute
) async throws -> AsyncResponseEncodable {
  switch route {
  case .fetch:
    return await database.events[courseId] ?? []
  case let .create(event):
    return try await database.createEvent(courseId: courseId, date: event.date)
  }
}

extension Course {
  static let initialData: [Course] = [
    .previewIntroToThePiano,
    .previewIntroToImprovisation,
    .previewMakingSenseOfModes,
    .previewHarmony101,
    .previewImprovObstacleCourse,
    .previewIntroToMusicTheory,
    .previewPianoJumpstart
  ]
}
