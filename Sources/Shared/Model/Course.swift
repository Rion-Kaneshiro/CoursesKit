import Foundation

public struct Course: Codable, Equatable, Identifiable {
  public var id: Int
  public let title: String
  public let description: String
  public let tutor: Tutor
  public let price: Price
//  public let subtitle: String?
//  public let imageURL: URL
//  public let author: Author
//  public let availableSubscriptions: Int
  
//  public init(id: Int, title: String, subtitle: String?, imageURL: URL, author: Author, availableSubscriptions: Int = 10) {
//    self.id = id
//    self.title = title
//    self.subtitle = subtitle
//    self.imageURL = imageURL
//    self.author = author
//    self.availableSubscriptions = availableSubscriptions
//  }
  
  public init(id: Int, title: String, description: String, tutor: Tutor, price: Price) {
    self.id = id
    self.title = title
    self.description = description
    self.tutor = tutor
    self.price = price
  }
}

public struct Price: Codable, Equatable {
  public let value: Double
  public let currency: String
  
  public init(value: Double, currency: String) {
    self.value = value
    self.currency = currency
  }
}

extension Course {
  public static let previewIntroToThePiano: Course = .init(
    id: 0,
    title: "An Intro to the Piano",
    description: "Everything you need to get started playing the Piano.",
    tutor: .previewCharlesCornell,
    price: .init(value: 99.0, currency: "EUR")
//    subtitle: nil,
//    imageURL: URL(string: "https://process.fs.teachablecdn.com/ADNupMnWyR7kCWRvm76Laz/resize=width:705/https://cdn.filestackcontent.com/7XtZzBAdTUqaMqroj5Fc")!,
//    author: .previewCharlesCornell,
//    availableSubscriptions: 6
  )
  
  public static let previewIntroToImprovisation: Course = .init(
    id: 1,
    title: "Intro to Improvisation",
    description: "Your Introduction to Improvisation.",
    tutor: .previewCharlesCornell,
    price: .init(value: 99.0, currency: "EUR")
//    subtitle: nil,
//    imageURL: URL(string: "https://process.fs.teachablecdn.com/ADNupMnWyR7kCWRvm76Laz/resize=width:705/https://cdn.filestackcontent.com/qhY31V9aQhKn5cHzd7Mg")!,
//    author: .previewCharlesCornell
  )
  
  public static let previewMakingSenseOfModes: Course = .init(
    id: 2,
    title: "Making sense of Modes",
    description: "What modes are, how to play them and how to actually use them.",
    tutor: .previewCharlesCornell,
    price: .init(value: 99.0, currency: "EUR")
//    imageURL: URL(string: "https://process.fs.teachablecdn.com/ADNupMnWyR7kCWRvm76Laz/resize=width:705/https://www.filepicker.io/api/file/JGkFLxaR2yhLjG6JxBpK")!,
//    author: .previewCharlesCornell
  )
  
  public static let previewHarmony101: Course = .init(
    id: 3,
    title: "Harmony 101",
    description: "Your In-Depth to understanding and applying harmony.",
    tutor: .previewDavidDeJesus,
    price: .init(value: 99.0, currency: "EUR")
//
//    subtitle: ,
//    imageURL: URL(string: "https://process.fs.teachablecdn.com/ADNupMnWyR7kCWRvm76Laz/resize=width:705/https://file-uploads.teachablecdn.com/2605d90876624e55af45dc3f9b9226f1/f33f926b3dfd4e6cbf600fc47e068ed1")!,
//    author: .previewDavidDeJesus,
//    availableSubscriptions: 1
  )
  
  public static let previewImprovObstacleCourse: Course = .init(
    id: 4,
    title: "Improv Obstacle Course",
    description: "The 30-part challenge to help you reach new improvisational heights.",
    tutor: .previewDavidDeJesus,
    price: .init(value: 99.0, currency: "EUR")
//    subtitle: ,
//    imageURL: URL(string: "https://process.fs.teachablecdn.com/ADNupMnWyR7kCWRvm76Laz/resize=width:705/https://cdn.filestackcontent.com/8edJeK7QTG3VwryqPYi9")!,
//    author: .previewDavidDeJesus
  )
  
  public static let previewIntroToMusicTheory: Course = .init(
    id: 5,
    title: "Intro to Music Theory",
    description: "Your Introduction to Music Theory.",
    tutor: .previewCharlesCornell,
    price: .init(value: 99.0, currency: "EUR")
//    subtitle: ,
//    imageURL: URL(string: "https://process.fs.teachablecdn.com/ADNupMnWyR7kCWRvm76Laz/resize=width:705/https://cdn.filestackcontent.com/MDemYGgRYqp0Hm1FHIza")!,
//    author: .previewCharlesCornell,
//    availableSubscriptions: 0
  )
  
  public static let previewPianoJumpstart: Course = .init(
    id: 6,
    title: "Piano Jumpstart",
    description: "Gitting you to play the Piano in no-time.",
    tutor: .previewCharlesCornell,
    price: .init(value: 99.0, currency: "EUR")
//    subtitle: nil,
//    imageURL: URL(string: "https://process.fs.teachablecdn.com/ADNupMnWyR7kCWRvm76Laz/resize=width:705/https://cdn.filestackcontent.com/r9QMO6C3RwK4jI7ALnNr")!,
//    author: .previewCharlesCornell
  )
}
