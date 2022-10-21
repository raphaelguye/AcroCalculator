import Calculator
import Foundation

struct MCFreestyleRepository: AcrobaticRepositoryProtocol {
  private static let entrancesSample: [Figure] = [.init(title: "Staff"), .init(title: "Bettarini")]
  private static let figuresSample: [Figure] = [.init(title: "Tucked"), .init(title: "Picked"), .init(title: "Straight"), .init(title: "1/2 turn tucked"), .init(title: "Tucked with 1/2 twist"), .init(title: "Straight with 1/1 twist")]
  private static let landingSample: [Figure] = [.init(title: "Standard"), .init(title: "Between legs of partner"), .init(title: "On waist facing partner"), .init(title: "In partner's arms"), .init(title: "On shoulders"), .init(title: "Others")]

  func fetchEntrances() -> [Figure] {
    Self.entrancesSample
  }

  func fetchFigures() -> [Figure] {
    Self.figuresSample
  }

  func fetchLandings() -> [Figure] {
    Self.landingSample
  }
}
