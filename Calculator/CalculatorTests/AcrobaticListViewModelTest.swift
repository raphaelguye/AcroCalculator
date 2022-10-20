import XCTest
@testable import Calculator

final class AcrobaticListViewModelTest: XCTestCase {

  // MARK: Internal

  func testInit() throws {
    let defaultNbOfAcrobatics = 6
    let viewModel = AcrobaticListViewModel()
    assertViewModelInitialized(viewModel, nbOfAcrobatics: defaultNbOfAcrobatics)
  }

  func testInitNbOfAcrobatics() throws {
    let nbOfAcrobatics = 3
    let viewModel = AcrobaticListViewModel(nbOfAcrobatics: nbOfAcrobatics)
    assertViewModelInitialized(viewModel, nbOfAcrobatics: nbOfAcrobatics)
  }

  func testInitListOfAcrobatics() throws {
    let acrobatics: [Acrobatic] = [.init(position: 1), .init(position: 2)]
    let nbOfAcrobatics = acrobatics.count
    let viewModel = AcrobaticListViewModel(acrobatics: acrobatics)
    assertViewModelInitialized(viewModel, nbOfAcrobatics: nbOfAcrobatics)
  }

  @MainActor
  func testDidSelectAcrobaticAndCancel() async throws {
    // Arrange
    let viewModel = AcrobaticListViewModel()
    guard let selectedAcrobatic = viewModel.acrobatics.first else {
      throw NSError()
    }

    // Act 1
    viewModel.didSelectAcrobatic(selectedAcrobatic)

    await Task.yield()

    // Assert 1
    XCTAssertTrue(viewModel.isAcrobaticSheetDisplayed)
    XCTAssertEqual(0, viewModel.selectedAcrobaticIndex) // First index
    XCTAssertEqual(viewModel.selectedGroup, selectedAcrobatic.group)
    XCTAssertNil(viewModel.selectedEntrance)
    XCTAssertNil(viewModel.selectedFirstElement)
    XCTAssertNil(viewModel.selectedLanding)

    // Act 2
    viewModel.selectedGroup = .rotation
    viewModel.selectedEntrance = Figure(title: "entrance")
    viewModel.selectedFirstElement = Figure(title: "first")
    viewModel.selectedLanding = Figure(title: "landing")
    viewModel.didCancelSheet()

    // Assert 2
    XCTAssertEqual(viewModel.acrobatics.first?.group, .notAssigned)
    XCTAssertNil(viewModel.acrobatics.first?.entrance)
    XCTAssertNil(viewModel.acrobatics.first?.firstElement)
    XCTAssertNil(viewModel.acrobatics.first?.landing)
    XCTAssertFalse(viewModel.isAcrobaticSheetDisplayed)
    XCTAssertNil(viewModel.selectedAcrobaticIndex)
  }

  @MainActor
  func testDidSelectAcrobaticAndSave() async throws {
    // Arrange
    let viewModel = AcrobaticListViewModel()
    guard let selectedAcrobatic = viewModel.acrobatics.first else {
      throw NSError()
    }
    let entrance = Figure(title: "entrance")
    let firstElement = Figure(title: "first")
    let landing = Figure(title: "landing")

    // Act 1
    viewModel.didSelectAcrobatic(selectedAcrobatic)

    await Task.yield()

    // Assert 1
    XCTAssertTrue(viewModel.isAcrobaticSheetDisplayed)
    XCTAssertEqual(0, viewModel.selectedAcrobaticIndex) // First index
    XCTAssertEqual(viewModel.selectedGroup, selectedAcrobatic.group)
    XCTAssertEqual(viewModel.selectedGroup, .notAssigned)
    XCTAssertNil(viewModel.selectedEntrance)
    XCTAssertNil(viewModel.selectedFirstElement)
    XCTAssertNil(viewModel.selectedLanding)

    // Act 2
    viewModel.selectedGroup = .rotation
    viewModel.selectedEntrance = entrance
    viewModel.selectedFirstElement = firstElement
    viewModel.selectedLanding = landing
    viewModel.didSaveSheet()

    // Assert 2
    sleep(5)
    XCTAssertEqual(viewModel.acrobatics.first?.group, .rotation)
    XCTAssertEqual(viewModel.acrobatics.first?.entrance, entrance)
    XCTAssertEqual(viewModel.acrobatics.first?.firstElement, firstElement)
    XCTAssertEqual(viewModel.acrobatics.first?.landing, landing)
    XCTAssertFalse(viewModel.isAcrobaticSheetDisplayed)
    XCTAssertNil(viewModel.selectedAcrobaticIndex)

    // Act 3
    viewModel.didSelectAcrobatic(selectedAcrobatic)

    // Assert 3
    XCTAssertEqual(viewModel.selectedGroup, .rotation)
    XCTAssertEqual(viewModel.selectedEntrance, entrance)
    XCTAssertEqual(viewModel.selectedFirstElement, firstElement)
    XCTAssertEqual(viewModel.selectedLanding, landing)
  }

  // MARK: Private

  private func assertViewModelInitialized(_ viewModel: AcrobaticListViewModel, nbOfAcrobatics: Int) {
    XCTAssertNotNil(viewModel.acrobatics)
    XCTAssertNotNil(viewModel.groups)
    XCTAssertEqual(AcrobaticGroup.notAssigned, viewModel.selectedGroup)
    XCTAssertNil(viewModel.selectedEntrance)
    XCTAssertNil(viewModel.selectedFirstElement)
    XCTAssertNil(viewModel.selectedLanding)
    XCTAssertEqual(nbOfAcrobatics, viewModel.acrobatics.count)
    XCTAssertFalse(viewModel.isAcrobaticSheetDisplayed)

    let freestyleGroups: [AcrobaticGroup] = [.notAssigned, .forward, .backward, .dive, .rotation]
    for group in freestyleGroups {
      XCTAssertTrue(viewModel.groups.contains(group))
    }
  }

}
