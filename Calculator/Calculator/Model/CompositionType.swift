import Foundation

enum CompositionType {
  case entrance
  case firstFigure
  case landing

  var description: String {
    switch self {
    case .entrance: return "Entrance"
    case .firstFigure: return "1st element"
    case .landing: return "Landing"
    }
  }
}
