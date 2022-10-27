import SwiftUI

// MARK: - AcrobaticListView

public struct AcrobaticListView: View {

  // MARK: Lifecycle

  public init(viewModel: AcrobaticListViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  // MARK: Public

  public var body: some View {
    content
      .sheet(isPresented: $viewModel.isAcrobaticSheetDisplayed) {
        acrobaticSheet
      }
  }

  // MARK: Internal

  @StateObject var viewModel: AcrobaticListViewModel

}

extension AcrobaticListView {
  private var content: some View {
    VStack {
      List(viewModel.acrobatics) { acrobatic in
        listCell(for: acrobatic)
      }
      HStack {
        Spacer()
        Text("Total score: ")
        Text("\(viewModel.routineQuotation)")
        Spacer()
      }.font(.title).padding()
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
          Section {
            detailCell(for: .entrance, selectionBinding: $viewModel.selectedEntrance)
            detailCell(for: .firstFigure, selectionBinding: $viewModel.selectedFirstElement)
            detailCell(for: .landing, selectionBinding: $viewModel.selectedLanding)
          }
          Section {
            HStack {
              Spacer()
              Text("Score: ")
              Text("\(viewModel.selectedQuotation)")
              Spacer()
            }.font(.title).padding()
          }
        }
        Spacer()
      }
      .navigationTitle("Acrobatic")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar(content: toolBarContent)
    }
  }

  private func listCell(for acrobatic: Acrobatic) -> some View {
    Button {
      viewModel.didSelectAcrobatic(acrobatic)
    } label: {
      HStack {
        if acrobatic.isFilled() {
          acrobaticCell(for: acrobatic)
          Spacer()
        } else {
          placeholderCell()
        }
      }
    }
  }

  private func acrobaticCell(for acrobatic: Acrobatic) -> some View {
    VStack(alignment: .leading) {
      HStack {
        Text("\(acrobatic.position)") //TODO: Circle
        Spacer()
        Text("\(acrobatic.group.description)")
        Spacer()
      }
//      .background(Color.green) //TODO: Color by group
      .fontWeight(.semibold)
      .font(.title2)

      Text(acrobatic.entrance?.title ?? "")
      Text(acrobatic.firstElement?.title ?? "")
      Text(acrobatic.landing?.title ?? "")
    }
  }

  private func placeholderCell() -> some View {
    HStack {
      Text("Select an acrobatic")
      Spacer()
    }
  }

  private func detailCell(
    for compositionType: CompositionType,
    selectionBinding: Binding<Figure?>)
    -> some View
  {
    NavigationLink {
      CompositionListView(
        viewModel: viewModel.createCompositionListViewModel(for: compositionType, selectionBinding: selectionBinding)
      )
      .navigationTitle(compositionType.description)
    } label: {
      HStack {
        Text(compositionType.description)
        Spacer()
        Text(viewModel.getSelectedFigureTitle(for: compositionType) ?? "")
      }
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
      viewModel: AcrobaticListViewModel(
        acrobaticRepository: FakeAcrobaticRepository(),
        acrobatics: Acrobatic.sampleList)
    )
  }
}
