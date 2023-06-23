import ComposableArchitecture
import Foundation
import Model

public struct AddEventReducer: ReducerProtocol {
  public struct State: Equatable {
    @BindingState var date: Date = .now
    
    public init(date: Date = .now) {
      self.date = date
    }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case cancelButtonTapped
    case delegate(Delegate)
    case doneButtonTapped
    
    public enum Delegate: Equatable {
      case cancel
      case save(Date)
    }
  }
  
  public init() {}
  
  public var body: some ReducerProtocolOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case .cancelButtonTapped:
        return .send(.delegate(.cancel))
      case .delegate:
        return .none
      case .doneButtonTapped:
        return .send(.delegate(.save(state.date)))
      }
    }
  }
}
