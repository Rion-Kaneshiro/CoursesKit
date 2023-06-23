@testable import Server
import Dependencies
import Foundation
import Model
import XCTVapor

final class AppTests: XCTestCase {
  func testFetchCourses() async throws {
    let app = Application(.testing)
    defer { app.shutdown() }
    try await configure(app)
    
    let testCourses = await database.availableCourses
    
    try app.test(.GET, "courses", afterResponse: { res in
      XCTAssertEqual(res.status, .ok)
      
      let courses = try res.content.decode([Course].self)
      
      XCTAssertEqual(courses, testCourses)
    })
  }
  
  func testFetchEvents() async throws {
    try await withDependencies {
      $0.uuid = .incrementing
    } operation: {
      let app = Application(.testing)
      defer { app.shutdown() }
      try await configure(app)
      
      let testEvents = try await database.createEvent(courseId: 0, date: Date(timeIntervalSince1970: 0))
      
      try app.test(.GET, "courses/0/events", afterResponse: { res in
        XCTAssertEqual(res.status, .ok)
        
        let courses = try res.content.decode([Event].self)
        
        XCTAssertEqual(courses, testEvents)
      })
    }
  }
  
  // TODO: Test not passing yet
  func testCreateEvent() async throws {
    try await withDependencies {
      $0.uuid = .incrementing
    } operation: {
      let app = Application(.testing)
      defer { app.shutdown() }
      try await configure(app)
      
      try app.test(
        .POST, "courses/0/events",
        beforeRequest: { request in
          do {
            try request.content.encode(CreateEvent(date: Date(timeIntervalSince1970: 0)))
          } catch {
            throw error
          }
        },
        afterResponse: { response in
          XCTAssertEqual(response.status, .ok)
          
          let events = try response.content.decode([Event].self)
          
          XCTAssertEqual(events, [Event(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, courseId: 0, date: 0, enrolled: false)])
        })
    }
  }
}
