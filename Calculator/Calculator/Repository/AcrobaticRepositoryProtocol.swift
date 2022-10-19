import Foundation

public protocol AcrobaticRepositoryProtocol {
  func fetchEntrances() -> [Entrance]
}

struct FakeAcrobaticRepository: AcrobaticRepositoryProtocol {

  func fetchEntrances() -> [Entrance] {
    [.init(title: "Staff"), .init(title: "Bettarini")]
  }

}
