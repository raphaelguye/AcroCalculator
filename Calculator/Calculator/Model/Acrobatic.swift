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
  public func isFilled() -> Bool {
    group != .notAssigned
  }
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
