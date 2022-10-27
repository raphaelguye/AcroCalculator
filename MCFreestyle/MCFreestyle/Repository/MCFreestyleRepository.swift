import Calculator
import Foundation

// MARK: - MCFreestyleRepository

struct MCFreestyleRepository: AcrobaticRepositoryProtocol {
  func fetchEntrances() -> [Figure] {
    Self.entrancesSample
  }

  func fetchFigures(acrobaticGroup: AcrobaticGroup) -> [Figure] {
    switch acrobaticGroup {
    case .forward: return Self.forwardFiguresSample
    case .backward: return Self.backwardFiguresSample
    case .dive: return Self.diveFiguresSample
    case .rotation: return Self.rotationFiguresSample
    case .notAssigned: return []
    }
  }

  func fetchLandings() -> [Figure] {
    Self.landingSample
  }
}

extension MCFreestyleRepository {
  private static let entrancesSample: [Figure] = [
    .init(title: "Staff"),
    .init(title: "Bettarini"),
    .init(title: "From the waist"),
    .init(title: "Sitting on shoulders"),
    .init(title: "Standing on the floor"),
  ]

  private static let landingSample: [Figure] = [
    .init(title: "Standard"),
    .init(title: "Between legs of partner"),
    .init(title: "On waist facing partner"),
    .init(title: "In partner's arms"),
    .init(title: "On shoulders"),
    .init(title: "Others"),
  ]

  private static let forwardFiguresSample: [Figure] = [
    .init(title: "Tucked", quotation: 4),
    .init(title: "Picked", quotation: 5),
    .init(title: "Straight", quotation: 6),
    .init(title: "1/2 turn tucked", quotation: 6),
    .init(title: "1/2 turn picked", quotation: 7),
    .init(title: "1/2 turn straight", quotation: 8),
    .init(title: "1/2 turn tucked landing on the arms, exit between partner's legs", quotation: 8),
    .init(title: "1/2 turn picked landing on the arms, exit between partner's legs", quotation: 9),
    .init(title: "1/2 turn straight landing on the arms, exit between partner's legs", quotation: 10),
    .init(title: "Tucked with 1/2 twist", quotation: 5),
    .init(title: "Picked with 1/2 twist", quotation: 6),
    .init(title: "Straight with 1/2 twist", quotation: 7),
    .init(title: "Straight with 1/2 twist", quotation: 7),
    .init(title: "Straight with 1/1 twist", quotation: 8),
    .init(title: "Straight with 3/2 twist", quotation: 10),
    .init(title: "3/2 tucked landing on partner's chest", quotation: 8),
    .init(title: "3/2 tucked landing on partner's back, exit between partner's legs", quotation: 10),
  ]

  private static let backwardFiguresSample: [Figure] = [
    .init(title: "Tucked", quotation: 4),
    .init(title: "Picked", quotation: 5),
    .init(title: "Straight", quotation: 6),
    .init(title: "Straight with 1/2 twist", quotation: 7),
    .init(title: "Straight with 1/1 twist", quotation: 8),
    .init(title: "Straight with 3/2 twist", quotation: 9),
    .init(title: "Straight with 2/2 twist", quotation: 10),
    .init(title: "3/2 tucked", quotation: 8),
    .init(title: "3/2 picked", quotation: 9),
    .init(title: "3/2 straight", quotation: 10),
    .init(title: "3/2 tucked + rolling to dive", quotation: 9),
    .init(title: "3/2 picked + rolling to dive", quotation: 10),
  ]

  private static let diveFiguresSample: [Figure] = [
    .init(title: "front dive tucked, landing on the partner's chest", quotation: 4),
    .init(title: "front dive picked, landing on the partner's chest", quotation: 5),
    .init(title: "front dive straight, landing on the partner's chest", quotation: 6),
    .init(title: "front dive tucked, landing on the partner's back, exit between legs", quotation: 6),
    .init(title: "front dive picked, landing on the partner's back, exit between legs", quotation: 7),
    .init(title: "front dive straight, landing on the partner's back, exit between legs", quotation: 8),
    .init(title: "1/2 turn dive with tucked body during the flying and 1/2 turn for the partner before the landing", quotation: 8),
    .init(title: "1/2 turn dive with picked body during the flying and 1/2 turn for the partner before the landing", quotation: 9),
    .init(title: "1/2 turn dive with straight body during the flying and 1/2 turn for the partner before the landing", quotation: 10),
    .init(title: "1/1 twist wirthin straight dive, landing on the partner's back, exit between legs", quotation: 10),
  ]

  private static let rotationFiguresSample: [Figure] = [
    .init(title: "Dulaine 3 rotations", quotation: 6),
    .init(title: "Dulaine 4 rotations", quotation: 7),
    .init(title: "Shoulderball 3 rotations", quotation: 6),
    .init(title: "Shoulderball 4 rotations", quotation: 7),
    .init(title: "Tie 3 rotations", quotation: 5),
    .init(title: "TIe 4 rotations", quotation: 6),
    .init(title: "Combination 3+3 with change of direction", quotation: 9),
    .init(title: "Combination 3+3 in same direction", quotation: 10),
  ]
}
