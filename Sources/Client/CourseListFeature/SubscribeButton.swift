//import SwiftUI
//
//enum SubscriptionState: Equatable {
//  case subscribing
//  case unsubscribed(Int)
//  case subscribed
//  case unavailable
//}
//
//struct SubscribeButton: View {
//  
//  let state: SubscriptionState
//  let action: @Sendable () -> Void
//  
//  var body: some View {
//    switch state {
//    case .subscribing:
//      Button(action: {}) {
//        Text("Subscribing...")
//      }
//      .buttonStyle(SubscribingButtonStyle())
//    case .unsubscribed(let value):
//      Button(action: action) {
//        Text("Only \(value) left")
//      }
//      .buttonStyle(UnsubscribedButtonStyle())
//    case .subscribed:
//      Button(action: {}) {
//        Label("Subscribed", systemImage: "music.quarternote.3")
//      }
//      .buttonStyle(SubscribedButtonStyle())
//    case .unavailable:
//      Button(action: {}) {
//        Label("Unavailable", systemImage: "slash.circle")
//      }
//      .buttonStyle(UnavailableButtonStyle())
//    }
//  }
//}
//
//private struct SubscribingButtonStyle: ButtonStyle {
//  func makeBody(configuration: Configuration) -> some View {
//    HStack(spacing: 4) {
//      ProgressView()
//        .tint(.white)
//      configuration.label
//    }
//    .font(.subheadline)
//    .padding(6)
//    .background(.blue, in: RoundedRectangle(cornerRadius: 6))
//    .foregroundColor(Color.white)
//    .disabled(true)
//  }
//}
//
//private struct UnsubscribedButtonStyle: ButtonStyle {
//  func makeBody(configuration: Configuration) -> some View {
//    configuration.label
//      .font(.subheadline)
//      .padding(6)
//      .background(.blue, in: RoundedRectangle(cornerRadius: 6))
//      .foregroundColor(Color.white)
//      .opacity(configuration.isPressed ? 0.3 : 1.0)
//  }
//}
//
//private struct SubscribedButtonStyle: ButtonStyle {
//  func makeBody(configuration: Configuration) -> some View {
//    configuration.label
//      .font(.footnote)
//      .padding(6)
//      .overlay {
//        RoundedRectangle(cornerRadius: 6)
//          .stroke()
//      }
//      .foregroundColor(.green)
//      .disabled(true)
//  }
//}
//
//private struct UnavailableButtonStyle: ButtonStyle {
//  func makeBody(configuration: Configuration) -> some View {
//      configuration.label
//        .font(.footnote)
//        .padding(6)
//        .overlay {
//          RoundedRectangle(cornerRadius: 6)
//            .stroke()
//        }
//        .foregroundColor(.red)
//  }
//}
//
//struct SubscribeButton_Previews: PreviewProvider {
//  static var previews: some View {
//    VStack {
//      SubscribeButton(state: .subscribing) {}
//      SubscribeButton(state: .unsubscribed(8)) {}
//      SubscribeButton(state: .subscribed) {}
//      SubscribeButton(state: .unavailable) {}
//    }
//  }
//}
