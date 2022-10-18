import SwiftUI

// MARK: - AcrobaticListView

public struct AcrobaticListView: View {

  @ObservedObject var viewModel: AcrobaticListViewModel

  public init(viewModel: AcrobaticListViewModel) {
    self.viewModel = viewModel
  }

  public var body: some View {
    content
      .sheet(isPresented: $viewModel.isAcrobaticSheetDisplayed) {
        Text("todo")
      }
  }
}

extension AcrobaticListView {
  private var content: some View {
    List(viewModel.acrobatics) { acrobatic in
      Text("Acro \(acrobatic.id)")
        .onTapGesture {
          viewModel.didSelectAcrobatic(acrobatic)
        }
    }
  }
}

// MARK: - AcrobaticListView_Previews

struct AcrobaticListView_Previews: PreviewProvider {
  static var previews: some View {
    AcrobaticListView(
      viewModel: AcrobaticListViewModel()
    )
  }
}
