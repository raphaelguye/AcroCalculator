import Foundation

public protocol AcrobaticRepositoryProtocol {
  func fetchEntrances() -> [Figure]
  func fetchFigures() -> [Figure]
  func fetchLandings() -> [Figure]
}

struct FakeAcrobaticRepository: AcrobaticRepositoryProtocol {

  static let entrancesSample: [Figure] = [.init(title: "Staff"), .init(title: "Bettarini")]
  static let figuresSample: [Figure] = [.init(title: "Tucked", quotation: 4), .init(title: "Picked", quotation: 5), .init(title: "Straight", quotation: 6)]
  static let landingSample: [Figure] = [.init(title: "Standard"), .init(title: "Between legs of partner"), .init(title: "On waist facing partner")]

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
