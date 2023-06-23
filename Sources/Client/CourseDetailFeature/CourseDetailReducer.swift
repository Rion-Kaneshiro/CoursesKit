import AddEventFeature
import ComposableArchitecture
import CourseClient
import Foundation
import IdentifiedCollections
import Model

enum Enrollability: CaseIterable, Equatable {
  case available
  case unavailable
  case enrolling
  case enrolled
}

public struct CourseDetailReducer: ReducerProtocol {
  public struct State: Equatable {
    struct Row: Equatable, Identifiable {
      let id: UUID
      let title: String
      let subtitle: String?
      let enrollability: Enrollability
    }
    
    @PresentationState var addEvent: AddEventReducer.State?
    
    let course: Course
    var title: String {
      course.title
    }
    
    var canAddEvents: Bool {
      // This has to be derived from the users permissions.
      return true
    }
    
    var rows: IdentifiedArrayOf<Row> = []
    
    public init(course: Course) {
      self.course = course
    }
  }
  
  public enum Action: Equatable {
    case addEventButtonTapped
    case addEvent(PresentationAction<AddEventReducer.Action>)
    case fetch
    case fetchFinished(TaskResult<[Event]>)
  }
  
  @Dependency(\.apiClient) private var apiClient
  
  public init() {}
  
  public var body: some ReducerProtocolOf<Self> {
    Reduce { state, action in
      switch action {
      case .addEventButtonTapped:
        state.addEvent = .init()
        return .none
      case .addEvent(.presented(.delegate(.cancel))):
        state.addEvent = nil
        return .none
      case let .addEvent(.presented(.delegate(.save(date)))):
        state.addEvent = nil
        return .task { [courseId = state.course.id] in
          await .fetchFinished(
            TaskResult { try await apiClient.decodedResponse(for: .courses(.course(courseId, .create(.init(date: date))))).value }
          )
        }
      case .addEvent:
        return .none
      case .fetch:
        return .task { [courseId = state.course.id] in
          await .fetchFinished(TaskResult { try await apiClient.decodedResponse(for: .courses(.course(courseId))).value })
        }
      case let .fetchFinished(.success(events)):
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        state.rows = IdentifiedArray(uniqueElements: events.map {
          State.Row(
            id: $0.id,
            title: formatter.string(from: Date(timeIntervalSince1970: $0.date)),
            subtitle: nil,
            enrollability: $0.enrolled ? .enrolled : .available
          )
        })
        
        return .none
      case let .fetchFinished(.failure(error)):
        print(error)
        return .none
      }
    }
    .ifLet(\.$addEvent, action: /Action.addEvent) {
      AddEventReducer()
    }
  }
}
