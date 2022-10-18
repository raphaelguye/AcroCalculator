import Foundation

public class AcrobaticListViewModel: ObservableObject {

  // MARK: Lifecycle

  public init(nbOfAcrobatics: Int) {
    self.acrobatics = []
    for _ in 0..<nbOfAcrobatics {
      self.acrobatics.append(.init())
    }
  }

  public convenience init() {
    self.init(nbOfAcrobatics: 6)
  }

  func didSelectAcrobatic(_ acrobatic: Acrobatic) {
    isAcrobaticSheetDisplayed = true
  }

  // MARK: Internal

  @Published var acrobatics: [Acrobatic]
  @Published var isAcrobaticSheetDisplayed = false

}
