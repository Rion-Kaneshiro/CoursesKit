import AddEventFeature
import ComposableArchitecture
import Foundation
import Model
import SwiftUI

public struct CourseDetail: View {
  
  let store: StoreOf<CourseDetailReducer>
  
  public init(store: StoreOf<CourseDetailReducer>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      List {
        ForEach(viewStore.rows) { row in
          Section {
            EventRow(
              title: row.title,
              subtitle: row.subtitle,
              enrollability: row.enrollability
            ) {
              // TODO: Implement enrolling
            }
          }
        }
      }
      .task {
        viewStore.send(.fetch)
      }
      .navigationTitle(viewStore.title)
      .toolbar {
        if viewStore.canAddEvents {
          Button {
            viewStore.send(.addEventButtonTapped)
          } label: {
            Label("Add Event", systemImage: "plus")
          }
        }
      }
      .sheet(
        store: self.store.scope(
          state: \.$addEvent,
          action: { .addEvent($0) }
        )
      ) { store in
          AddEvent(store: store)
      }
    }
  }
}

struct EventRow: View {
  
  let title: String
  let subtitle: String?
  let enrollability: Enrollability
  
  let action: @Sendable () -> Void
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(title)
        if let subtitle {
          Text(subtitle)
            .font(.subheadline)
        }
      }
      Spacer()
      
      switch enrollability {
      case .available:
        Button("Enroll") {
          
        }
        .buttonStyle(.borderedProminent)
      case .unavailable:
        UnavailableView()
      case .enrolling:
        Button {
          // Intentianlly ignoring the action.
        } label: {
          HStack(spacing: 4) {
            ProgressView()
              .tint(.white)
            Text("Enrolling...")
          }
        }
        .buttonStyle(.borderedProminent)
      case .enrolled:
        SubscribedView()
      }
    }
    .padding(.vertical, 8)
  }
}

struct SubscribedView: View {
  var body: some View {
    Label("Subscribed", systemImage: "music.quarternote.3")
      .font(.footnote)
      .padding(8)
      .overlay {
        RoundedRectangle(cornerRadius: 6)
          .stroke()
      }
      .foregroundColor(.green)
  }
}

struct UnavailableView: View {
  var body: some View {
    Label("Unavailable", systemImage: "slash.circle")
      .font(.footnote)
      .padding(6)
      .overlay {
        RoundedRectangle(cornerRadius: 6)
          .stroke()
      }
      .foregroundColor(.red)
  }
}

struct CourseDetail_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      CourseDetail(
        store: .init(
          initialState: .init(course: Course.previewPianoJumpstart),
          reducer: CourseDetailReducer()
        )
      )
    }
  }
}
