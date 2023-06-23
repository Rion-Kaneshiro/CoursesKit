import CasePaths
import Foundation
import Model
import URLRouting

public enum EventsRoute: Equatable {
  case fetch
  case create(CreateEvent)
}

public enum CoursesRoute: Equatable {
  case fetch
  case course(Course.ID, EventsRoute = .fetch)
}

public enum SiteRoute: Equatable {
  case courses(CoursesRoute = .fetch)
}

let eventsRouter = OneOf {
  //GET /courses/:id/events
  Route(.case(EventsRoute.fetch))
  
  //POST /courses/:id/events
  Route(.case(EventsRoute.create)) {
    Method.post
    Body(.json(CreateEvent.self))
  }
}

let coursesRouter = OneOf {
  //GET /courses
  Route(.case(CoursesRoute.fetch))
  
  //GET /courses/:id/events
  Route(.case(CoursesRoute.course)) {
    Path { Digits(); "events" }
    eventsRouter
  }
}

public let router = OneOf {
  Route(.case(SiteRoute.courses)) {
    Path { "courses" }
    coursesRouter
  }
}
