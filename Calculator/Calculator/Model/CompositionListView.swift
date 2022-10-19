import SwiftUI

// MARK: - CompositionListView

struct CompositionListView: View {
  var body: some View {
    List {
      Text("Item 1")
      Text("Item 2")
      Text("Item 3")
    }
  }
}

// MARK: - CompositionListView_Previews

struct CompositionListView_Previews: PreviewProvider {
  static var previews: some View {
    CompositionListView()
  }
}
