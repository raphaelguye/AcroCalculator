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
    NavigationView {
      VStack {
        Picker("Group", selection: $viewModel.selectedGroup) {
          ForEach($viewModel.groups) { group in
            Text(group.wrappedValue.description)
          }
        }.pickerStyle(WheelPickerStyle())
        List {
          Text("Entrance")
          Text("1st element")
          Text("Landing")
        }
        Spacer()
      }
      .navigationTitle("Acrobatic")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar(content: toolBarContent)
    }
  }

  @ToolbarContentBuilder
  private func toolBarContent() -> some ToolbarContent {
    ToolbarItemGroup(placement: .navigationBarLeading) {
      Button {
        viewModel.didCancelSheet()
      } label: {
        Text("Cancel")
      }
    }

    ToolbarItemGroup(placement: .navigationBarTrailing) {
      Button {
        viewModel.didSaveSheet()
      } label: {
        Text("Save")
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
