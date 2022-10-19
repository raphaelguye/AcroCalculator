import Foundation

public protocol AcrobaticRepositoryProtocol {
  func fetchEntrances() -> [Figure]
  func fetchFigures() -> [Figure]
  func fetchLandings() -> [Figure]
}

struct FakeAcrobaticRepository: AcrobaticRepositoryProtocol {

  func fetchEntrances() -> [Figure] {
    [.init(title: "Staff"), .init(title: "Bettarini")]
  }

  func fetchFigures() -> [Figure] {
    [.init(title: "Tucked"), .init(title: "Picked"), .init(title: "Straight")]
  }

  func fetchLandings() -> [Figure] {
    [.init(title: "Standard"), .init(title: "Between legs of partner"), .init(title: "On waist facing partner")]
  }

}
