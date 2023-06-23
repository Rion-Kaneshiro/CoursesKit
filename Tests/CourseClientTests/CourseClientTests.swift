import CourseClient
import Dependencies
import Foundation
import Model
import SiteRouter
import XCTest

final class CourseClientTests: XCTestCase {
  
  func testFetchCourses() async throws {
    let testCourses = [Course(id: 0, title: "Test 1", description: "Test Description", tutor: .previewCharlesCornell, price: .init(value: 99.0, currency: "EUR"))]
    
    try await withDependencies {
      $0.apiClient = .failing.override(.courses(.fetch)) {
        try .ok(testCourses)
      }
    } operation: {
      @Dependency(\.apiClient) var client
      let courses: [Course] = try await client.decodedResponse(for: .courses(.fetch)).value
      XCTAssertEqual(courses, testCourses)
    }
  }
  
  func testFetchEvents() async throws {
    let testEvents = [Event(id: UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")!, courseId: 0, date: 0, enrolled: false)]
    
    try await withDependencies {
      $0.apiClient = .failing.override(.courses(.course(0, .fetch))) {
        try .ok(testEvents)
      }
    } operation: {
      @Dependency(\.apiClient) var client
      let events: [Event] = try await client.decodedResponse(for: .courses(.course(0, .fetch))).value
      XCTAssertEqual(events, testEvents)
    }
  }
  
  func testCreateEvent() async throws {
    let testEvents = [Event(id: UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")!, courseId: 0, date: 0, enrolled: false)]
    
    try await withDependencies {
      $0.apiClient = .failing.override(.courses(.course(0, .create(.init(date: Date(timeIntervalSince1970: 0)))))) {
        try .ok(testEvents)
      }
    } operation: {
      @Dependency(\.apiClient) var client
      let events: [Event] = try await client.decodedResponse(for: .courses(.course(0, .create(.init(date: Date(timeIntervalSince1970: 0)))))).value
      XCTAssertEqual(events, testEvents)
    }
  }
}
