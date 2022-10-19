import SwiftUI

// MARK: - AcrobaticListView

public struct AcrobaticListView: View {

  // MARK: Lifecycle

  public init(viewModel: AcrobaticListViewModel) {
    self.viewModel = viewModel
  }

  // MARK: Public

  public var body: some View {
    content
      .sheet(isPresented: $viewModel.isAcrobaticSheetDisplayed) {
        acrobaticSheet
      }
  }

  // MARK: Internal

  @ObservedObject var viewModel: AcrobaticListViewModel

  // MARK: Private

  private var groupPickerStyle: some PickerStyle {
    get {
      #if os(macOS)
      SegmentedPickerStyle()
      #else
      WheelPickerStyle()
      #endif
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

  private var acrobaticSheet: some View {
    VStack {
      Picker("Group", selection: $viewModel.selectedGroup) {
        ForEach($viewModel.groups) { group in
          Text(group.wrappedValue.description)
        }
      }.pickerStyle(groupPickerStyle)
      List {
        Text("Entrance")
        Text("1st element")
        Text("Landing")
      }
      Spacer()
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
