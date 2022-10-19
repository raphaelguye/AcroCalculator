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

  func testDidSelectAcrobaticAndCancel() throws {
    // Arrange
    let viewModel = AcrobaticListViewModel()
    guard let selectedAcrobatic = viewModel.acrobatics.first else {
      throw NSError()
    }

    // Act 1
    viewModel.didSelectAcrobatic(selectedAcrobatic)

    // Assert 1
    XCTAssertTrue(viewModel.isAcrobaticSheetDisplayed)
    XCTAssertEqual(0, viewModel.selectedAcrobaticIndex) // First index
    XCTAssertEqual(viewModel.selectedGroup, selectedAcrobatic.group)

    // Act 2
    viewModel.selectedGroup = .rotation
    viewModel.didCancelSheet()

    // Assert 2
    XCTAssertEqual(viewModel.acrobatics.first?.group, .notAssigned)
    XCTAssertFalse(viewModel.isAcrobaticSheetDisplayed)
    XCTAssertNil(viewModel.selectedAcrobaticIndex)
    XCTAssertEqual(viewModel.selectedGroup, .rotation) // No reset of this property
  }

  func testDidSelectAcrobaticAndSave() throws {
    // Arrange
    let viewModel = AcrobaticListViewModel()
    guard let selectedAcrobatic = viewModel.acrobatics.first else {
      throw NSError()
    }

    // Act 1
    viewModel.didSelectAcrobatic(selectedAcrobatic)

    // Assert 1
    XCTAssertTrue(viewModel.isAcrobaticSheetDisplayed)
    XCTAssertEqual(0, viewModel.selectedAcrobaticIndex) // First index
    XCTAssertEqual(viewModel.selectedGroup, selectedAcrobatic.group)
    XCTAssertEqual(viewModel.selectedGroup, .notAssigned)

    // Act 2
    viewModel.selectedGroup = .rotation
    viewModel.didSaveSheet()

    // Assert 2
    sleep(5)
    XCTAssertEqual(viewModel.acrobatics.first?.group, .rotation)
    XCTAssertFalse(viewModel.isAcrobaticSheetDisplayed)
    XCTAssertNil(viewModel.selectedAcrobaticIndex)
    XCTAssertEqual(viewModel.selectedGroup, .rotation) // No reset of this property
  }

  // MARK: Private

  private func assertViewModelInitialized(_ viewModel: AcrobaticListViewModel, nbOfAcrobatics: Int) {
    XCTAssertNotNil(viewModel.acrobatics)
    XCTAssertNotNil(viewModel.groups)
    XCTAssertEqual(AcrobaticGroup.notAssigned, viewModel.selectedGroup)
    XCTAssertEqual(nbOfAcrobatics, viewModel.acrobatics.count)
    XCTAssertFalse(viewModel.isAcrobaticSheetDisplayed)

    let freestyleGroups: [AcrobaticGroup] = [.notAssigned, .forward, .backward, .dive, .rotation]
    for group in freestyleGroups {
      XCTAssertTrue(viewModel.groups.contains(group))
    }
  }

}
