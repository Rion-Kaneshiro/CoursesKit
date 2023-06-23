import Foundation

//public struct Author: Codable, Equatable {
//  public let name: String
//  public let avatarURL: URL
//  
//  public init(name: String, avatarURL: URL) {
//    self.name = name
//    self.avatarURL = avatarURL
//  }
//}
//
//extension Author {
//  public static let previewCharlesCornell: Author = .init(
//    name: "Charles Cornel",
//    avatarURL: URL(string: "https://process.fs.teachablecdn.com/ADNupMnWyR7kCWRvm76Laz/resize=width:30,height:30/https://www.filepicker.io/api/file/LgDMJW6TyzyimyNIE7lw")!
//  )
//  
//  public static let previewDavidDeJesus: Author = .init(
//    name: "David DeJesus",
//    avatarURL: URL(string: "https://process.fs.teachablecdn.com/ADNupMnWyR7kCWRvm76Laz/resize=width:30,height:30/https://www.filepicker.io/api/file/ChoBuHalTPqgw1A5zA0d")!
//  )
//}

public struct Tutor: Codable, Equatable, Identifiable {
  public let id: Int
  public let name: String
  
  public init(id: Int, name: String) {
    self.id = id
    self.name = name
  }
}

extension Tutor {
  public static let previewCharlesCornell = Tutor(id: 0, name: "Charles Cornel")
  public static let previewDavidDeJesus = Tutor(id: 1, name: "David DeJesus")
}
