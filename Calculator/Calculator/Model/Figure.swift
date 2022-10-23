import Foundation

// MARK: - Figure

public struct Figure: Identifiable {

  public var id = UUID.init().uuidString
  public var title: String
  public var quotation: Int

  public init(id: String = UUID.init().uuidString, title: String, quotation: Int = 0) {
    self.id = id
    self.title = title
    self.quotation = quotation
  }

}

// MARK: Equatable

extension Figure: Equatable {
  public static func == (lhs: Figure, rhs: Figure) -> Bool {
    lhs.id == rhs.id &&
      lhs.title == rhs.title &&
      lhs.quotation == rhs.quotation
  }
}
