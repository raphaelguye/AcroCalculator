import Foundation
import SwiftUI

// MARK: - AcrobaticListViewModel

public class AcrobaticListViewModel: ObservableObject {

  // MARK: Lifecycle

  private init(nbOfAcrobatics: Int, acrobatics: [Acrobatic]) {
    groups = [.notAssigned, .forward, .backward, .dive, .rotation]
    self.acrobatics = acrobatics
  }

  public convenience init(acrobatics: [Acrobatic]) {
    self.init(nbOfAcrobatics: acrobatics.count, acrobatics: acrobatics)
  }

  public convenience init(nbOfAcrobatics: Int) {
    var acrobatics: [Acrobatic] = []
    for i in 0..<nbOfAcrobatics {
      acrobatics.append(.init(position: i+1))
    }
    self.init(nbOfAcrobatics: nbOfAcrobatics, acrobatics: acrobatics)
  }

  public convenience init() {
    self.init(nbOfAcrobatics: 6)
  }

  // MARK: Internal

  @Published var acrobatics: [Acrobatic]
  @Published var groups: [AcrobaticGroup]
  @Published var isAcrobaticSheetDisplayed = false
  @Published var selectedGroup: AcrobaticGroup = .notAssigned

  // MARK: Private

  private var selectedAcrobaticIndex: Int?
}

extension AcrobaticListViewModel {
  func didSelectAcrobatic(_ acrobatic: Acrobatic) {
    isAcrobaticSheetDisplayed = true
    selectedAcrobaticIndex = acrobatics.firstIndex { acrobatic.id == $0.id }
    if let index = selectedAcrobaticIndex {
      selectedGroup = acrobatics[index].group
    }
  }

  func didCancelSheet() {
    resetSheetSelection()
  }

  func didSaveSheet() {
    Task {
      await MainActor.run {
        if let index = selectedAcrobaticIndex {
          acrobatics[index].group = selectedGroup
        }
        resetSheetSelection()
      }
    }
  }
}

extension AcrobaticListViewModel {
  private func resetSheetSelection() {
    isAcrobaticSheetDisplayed = false
    selectedAcrobaticIndex = nil
  }
}
