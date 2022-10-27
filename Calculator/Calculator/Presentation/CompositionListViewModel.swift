import Foundation
import SwiftUI

// MARK: - CompositionListViewModel

class CompositionListViewModel: ObservableObject {

  // MARK: Lifecycle

  init(compositionType: CompositionType, acrobaticGroup: AcrobaticGroup, selectedFigure: Binding<Figure?>, acrobaticRepository: AcrobaticRepositoryProtocol) {
    self.compositionType = compositionType
    self.acrobaticGroup = acrobaticGroup
    self.acrobaticRepository = acrobaticRepository
    _selectedFigureBinded = selectedFigure
    _selectedFigure = Published(wrappedValue: selectedFigureBinded)
  }

  // MARK: Internal

  @Published var figures: [Figure] = []

  @Published private(set) var selectedFigure: Figure? {
    didSet {
      selectedFigureBinded = selectedFigure
    }
  }

  // MARK: Private

  private let compositionType: CompositionType
  private let acrobaticGroup: AcrobaticGroup
  private let acrobaticRepository: AcrobaticRepositoryProtocol
  @Binding private var selectedFigureBinded: Figure?

}

extension CompositionListViewModel {
  func onViewAppear() {
    switch compositionType {
    case .entrance: figures = acrobaticRepository.fetchEntrances()
    case .firstFigure: figures = acrobaticRepository.fetchFigures(acrobaticGroup: acrobaticGroup)
    case .landing: figures = acrobaticRepository.fetchLandings()
    }
  }

  func didSelectFigure(_ figure: Figure) {
    Task {
      await MainActor.run {
        selectedFigure = figure
      }
    }
  }

  func isFigureSelected(_ figure: Figure) -> Bool {
    figure == selectedFigure
  }
}
