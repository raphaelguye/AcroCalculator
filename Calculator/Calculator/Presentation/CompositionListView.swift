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

  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @StateObject var viewModel: CompositionListViewModel
}

extension CompositionListView {
  private var content: some View {
    List(viewModel.figures) { figure in
      Button {
        viewModel.didSelectFigure(figure)
        self.presentationMode.wrappedValue.dismiss()
      } label: {
        HStack {
          Text(figure.title)
          Spacer()
          if viewModel.isFigureSelected(figure) {
            Image(systemName: "checkmark")
          }
        }
      }
    }
  }
}

// MARK: - CompositionListView_Previews

struct CompositionListView_Previews: PreviewProvider {
  static var previews: some View {
    CompositionListView(
      viewModel: CompositionListViewModel(
        compositionType: .firstFigure,
        acrobaticGroup: .backward,
        selectedFigure: .constant(.init(title: "figure")),
        acrobaticRepository: FakeAcrobaticRepository())
    )
  }
}
