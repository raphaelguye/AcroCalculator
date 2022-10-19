import Foundation

// MARK: - Figure

public struct Figure: Identifiable {

  public var id = UUID.init().uuidString
  public var title: String

}

// MARK: Equatable

extension Figure: Equatable {
  public static func == (lhs: Figure, rhs: Figure) -> Bool {
    lhs.id == rhs.id &&
      lhs.title == rhs.title
  }
}
