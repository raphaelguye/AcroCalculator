import SwiftUI

// MARK: - AcrobaticListView

public struct AcrobaticListView: View {

  @ObservedObject var viewModel: AcrobaticListViewModel

  public init(viewModel: AcrobaticListViewModel) {
    self.viewModel = viewModel
  }

  public var body: some View {
    List {
      ForEach(0..<viewModel.nbOfAcrobatics, id: \.self) {
        Text("Acro \($0+1)")
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
