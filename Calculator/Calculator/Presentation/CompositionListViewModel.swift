import Foundation
import SwiftUI

// MARK: - CompositionListViewModel

class CompositionListViewModel: ObservableObject {

  // MARK: Lifecycle

  init(compositionType: CompositionType, selectedFigure: Binding<Figure?>, acrobaticRepository: AcrobaticRepositoryProtocol) {
    self.compositionType = compositionType
    self.acrobaticRepository = acrobaticRepository
    _selectedFigureBinded = selectedFigure
  }

  // MARK: Internal

  @Published var figures: [Figure] = []

  @Published var selectedFigure: Figure? {
    didSet {
      selectedFigureBinded = selectedFigure
    }
  }

  // MARK: Private

  private let compositionType: CompositionType
  private let acrobaticRepository: AcrobaticRepositoryProtocol
  @Binding private var selectedFigureBinded: Figure?

}

extension CompositionListViewModel {
  func onViewAppear() {
    switch compositionType {
    case .entrance: figures = acrobaticRepository.fetchEntrances()
    case .firstFigure: figures = acrobaticRepository.fetchFigures()
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
