import Calculator
import SwiftUI

// MARK: - MCFreestyleRootView

public struct MCFreestyleRootView: View {

  public init() {
    // empty
  }

  public var body: some View {
    NavigationView {
      AcrobaticListView(
        viewModel: AcrobaticListViewModel(acrobaticRepository: MCFreestyleRepository())
      )
      .navigationTitle("Main Class Freestyle")
    }
  }
}

// MARK: - MCFreestyleRootView_Previews

struct MCFreestyleRootView_Previews: PreviewProvider {
  static var previews: some View {
    MCFreestyleRootView()
  }
}
