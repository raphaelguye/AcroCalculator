import Foundation

// MARK: - Acrobatic

struct Acrobatic: Identifiable {

  var id = UUID.init().uuidString
  var group: AcrobaticGroup?

}

// MARK: - AcrobaticGroup

enum AcrobaticGroup {
  case forward
  case backward
  case dive
  case rotation
}
