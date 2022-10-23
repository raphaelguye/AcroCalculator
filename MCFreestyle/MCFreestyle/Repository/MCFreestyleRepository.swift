import Calculator
import Foundation

struct MCFreestyleRepository: AcrobaticRepositoryProtocol {
  private static let entrancesSample: [Figure] = [.init(title: "Staff"), .init(title: "Bettarini")]
  private static let figuresSample: [Figure] = [.init(title: "Tucked", quotation: 4), .init(title: "Picked", quotation: 5), .init(title: "Straight", quotation: 6), .init(title: "1/2 turn tucked", quotation: 6), .init(title: "Tucked with 1/2 twist", quotation: 5), .init(title: "Straight with 1/1 twist", quotation: 8)]
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
