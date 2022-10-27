import Foundation

// MARK: - Acrobatic

public struct Acrobatic: Identifiable {

  public var id = UUID.init().uuidString
  public var position: Int
  public var group: AcrobaticGroup = .notAssigned
  public var entrance: Figure?
  public var firstElement: Figure?
  public var landing: Figure?

}

extension Acrobatic {
  public var quotation: Int {
    get {
      (entrance?.quotation ?? 0) +
        (firstElement?.quotation ?? 0) +
        (landing?.quotation ?? 0)
    }
  }

  public func isFilled() -> Bool {
    group != .notAssigned
  }

}

extension Acrobatic {
  public static let sampleList: [Acrobatic] = [
    .init(position: 1, group: .forward, entrance: Figure.init(title: "Staff"), firstElement: .init(title: "Picked"), landing: .init(title: "Standard")),
    .init(position: 2, group: .forward, entrance: Figure.init(title: "Bettarini"), firstElement: .init(title: "Straight"), landing: .init(title: "Standard")),
    .init(position: 3)
  ]
}

// MARK: - AcrobaticGroup

public enum AcrobaticGroup: Identifiable {
  case notAssigned
  case forward
  case backward
  case dive
  case rotation

  public var id: Self { self }

  public var description : String {
    switch self {
    case .forward: return "Forward"
    case .backward : return "Backward"
    case .dive: return "Dive"
    case .rotation: return "Rotation"
    case .notAssigned: return ""
    }
  }
}
