import ComposableArchitecture
import Foundation
import SwiftUI

public struct AddEvent: View {
  let store: StoreOf<AddEventReducer>
  
  public init(store: StoreOf<AddEventReducer>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      NavigationStack {
        List {
          DatePicker("Date", selection: viewStore.binding(\.$date))
        }
        .navigationTitle("Add Event")
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            Button("Cancel") {
              viewStore.send(.cancelButtonTapped)
            }
          }
          
          ToolbarItem(placement: .topBarTrailing) {
            Button("Done") {
              viewStore.send(.doneButtonTapped)
            }
          }
        }
      }
    }
  }
}
