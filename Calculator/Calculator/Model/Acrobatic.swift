import Foundation

// MARK: - Acrobatic

struct Acrobatic: Identifiable {

  var id = UUID.init().uuidString
  var group: AcrobaticGroup?

}

// MARK: - AcrobaticGroup

enum AcrobaticGroup: Identifiable {
  case forward
  case backward
  case dive
  case rotation

  var id: Self { self }

  var description : String {
    switch self {
    case .forward: return "Forward"
    case .backward : return "Backward"
    case .dive: return "Dive"
    case .rotation: return "Rotation"
    }
  }
}
