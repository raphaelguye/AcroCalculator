import Foundation

public class AcrobaticListViewModel: ObservableObject {

  // MARK: Lifecycle

  public init(nbOfAcrobatics: Int) {
    groups = [.forward, .backward, .dive, .rotation]
    acrobatics = []
    for _ in 0..<nbOfAcrobatics {
      acrobatics.append(.init())
    }
  }

  public convenience init() {
    self.init(nbOfAcrobatics: 6)
  }

  // MARK: Internal

  @Published var acrobatics: [Acrobatic]
  @Published var groups: [AcrobaticGroup]
  @Published var isAcrobaticSheetDisplayed = false
  var selectedGroup: AcrobaticGroup?

  func didSelectAcrobatic(_ acrobatic: Acrobatic) {
    isAcrobaticSheetDisplayed = true
  }

  func didCancelSheet() {
    isAcrobaticSheetDisplayed = false
  }

  func didSaveSheet() {
    isAcrobaticSheetDisplayed = false
  }

}
