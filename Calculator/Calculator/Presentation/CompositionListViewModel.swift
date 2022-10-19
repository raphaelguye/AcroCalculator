import Foundation

// MARK: - CompositionListViewModel

public class CompositionListViewModel: ObservableObject {

  // MARK: Lifecycle

  init(acrobaticRepository: AcrobaticRepositoryProtocol) {
    self.acrobaticRepository = acrobaticRepository
  }

  // MARK: Internal

  let acrobaticRepository: AcrobaticRepositoryProtocol
  @Published var entrances: [Entrance] = []

}

extension CompositionListViewModel {
  func onViewAppear() {
    entrances = acrobaticRepository.fetchEntrances()
  }
}
