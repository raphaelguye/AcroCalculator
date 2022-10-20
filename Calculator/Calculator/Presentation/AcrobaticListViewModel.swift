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
  @Published var selectedEntrance: Figure?
  @Published var selectedFirstElement: Figure?
  @Published var selectedLanding: Figure?

  var selectedAcrobaticIndex: Int?
}

extension AcrobaticListViewModel {
  func didSelectAcrobatic(_ acrobatic: Acrobatic) {
    Task {
      await MainActor.run {
        isAcrobaticSheetDisplayed = true
        selectedAcrobaticIndex = acrobatics.firstIndex { acrobatic.id == $0.id }
        if let index = selectedAcrobaticIndex {
          selectedGroup = acrobatics[index].group
          selectedEntrance = acrobatics[index].entrance
          selectedFirstElement = acrobatics[index].firstElement
          selectedLanding = acrobatics[index].landing
        }
      }
    }
  }

  func didCancelSheet() {
    resetSheetSelection()
  }

  func didSaveSheet() {
    if let index = selectedAcrobaticIndex {
      acrobatics[index].group = selectedGroup
      acrobatics[index].entrance = selectedEntrance
      acrobatics[index].firstElement = selectedFirstElement
      acrobatics[index].landing = selectedLanding
    }
    resetSheetSelection()
  }

  func getSelectedFigureTitle(for compositionType: CompositionType) -> String? {
    switch compositionType {
    case .entrance: return selectedEntrance?.title
    case .firstFigure: return selectedFirstElement?.title
    case .landing: return selectedLanding?.title
    }
  }
}

extension AcrobaticListViewModel {
  private func resetSheetSelection() {
    isAcrobaticSheetDisplayed = false
    selectedAcrobaticIndex = nil
  }
}
