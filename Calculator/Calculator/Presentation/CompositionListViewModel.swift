import Foundation

// MARK: - CompositionListViewModel

public class CompositionListViewModel: ObservableObject {

  // MARK: Lifecycle

  init(compositionType: CompositionType, acrobaticRepository: AcrobaticRepositoryProtocol) {
    self.compositionType = compositionType
    self.acrobaticRepository = acrobaticRepository
  }

  // MARK: Internal

  let compositionType: CompositionType
  let acrobaticRepository: AcrobaticRepositoryProtocol
  @Published var figures: [Figure] = []
  @Published var selectedFigure: Figure?

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
