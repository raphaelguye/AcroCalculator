import SwiftUI

// MARK: - CompositionListView

struct CompositionListView: View {

  init(viewModel: CompositionListViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  public var body: some View {
    content
      .onAppear {
        viewModel.onViewAppear()
      }
  }

  @StateObject var viewModel: CompositionListViewModel
}

extension CompositionListView {
  private var content: some View {
    List(viewModel.entrances) { entrance in
      Text(entrance.title)
    }
  }
}

// MARK: - CompositionListView_Previews

struct CompositionListView_Previews: PreviewProvider {
  static var previews: some View {
    CompositionListView(
      viewModel: CompositionListViewModel(
        acrobaticRepository: FakeAcrobaticRepository()
      )
    )
  }
}
