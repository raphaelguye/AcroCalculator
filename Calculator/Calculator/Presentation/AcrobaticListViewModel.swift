import Foundation
import SwiftUI

// MARK: - AcrobaticListViewModel

public class AcrobaticListViewModel: ObservableObject {

  // MARK: Lifecycle

  private init(acrobaticRepository: AcrobaticRepositoryProtocol, nbOfAcrobatics: Int, acrobatics: [Acrobatic]) {
    groups = [.notAssigned, .forward, .backward, .dive, .rotation]
    self.acrobaticRepository = acrobaticRepository
    self.acrobatics = acrobatics
  }

  public convenience init(acrobaticRepository: AcrobaticRepositoryProtocol, acrobatics: [Acrobatic]) {
    self.init(acrobaticRepository: acrobaticRepository, nbOfAcrobatics: acrobatics.count, acrobatics: acrobatics)
  }

  public convenience init(acrobaticRepository: AcrobaticRepositoryProtocol, nbOfAcrobatics: Int) {
    var acrobatics: [Acrobatic] = []
    for i in 0..<nbOfAcrobatics {
      acrobatics.append(.init(position: i+1))
    }
    self.init(acrobaticRepository: acrobaticRepository, nbOfAcrobatics: nbOfAcrobatics, acrobatics: acrobatics)
  }

  public convenience init(acrobaticRepository: AcrobaticRepositoryProtocol) {
    self.init(acrobaticRepository: acrobaticRepository, nbOfAcrobatics: 6)
  }

  // MARK: Internal

  @Published var acrobatics: [Acrobatic]
  @Published var groups: [AcrobaticGroup]
  @Published var isAcrobaticSheetDisplayed = false
  @Published var selectedGroup: AcrobaticGroup = .notAssigned
  @Published var selectedQuotation: Int = 0

  var selectedAcrobaticIndex: Int?

  @Published var selectedEntrance: Figure? {
    didSet {
      updateSelectedQuotation(selectedFigure: selectedEntrance)
    }
  }
  @Published var selectedLanding: Figure? {
    didSet {
      updateSelectedQuotation(selectedFigure: selectedLanding)
    }
  }
  @Published var selectedFirstElement: Figure? {
    didSet {
      updateSelectedQuotation(selectedFigure: selectedFirstElement)
    }
  }

  // MARK: Private

  private var acrobaticRepository: AcrobaticRepositoryProtocol
}

extension AcrobaticListViewModel {

  func createCompositionListViewModel(for compositionType: CompositionType, selectionBinding: Binding<Figure?>) -> CompositionListViewModel {
    CompositionListViewModel(
      compositionType: compositionType,
      selectedFigure: selectionBinding,
      acrobaticRepository: acrobaticRepository)
  }

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
  private func updateSelectedQuotation(selectedFigure: Figure?) {
    if selectedFigure != nil {
      selectedQuotation = (selectedEntrance?.quotation ?? 0) +
        (selectedFirstElement?.quotation ?? 0) +
        (selectedLanding?.quotation ?? 0)
    }
  }

  private func resetSheetSelection() {
    isAcrobaticSheetDisplayed = false
    selectedAcrobaticIndex = nil
  }
}
