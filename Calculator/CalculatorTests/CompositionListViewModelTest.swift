import SwiftUI
import XCTest
@testable import Calculator

final class CompositionListViewModelTest: XCTestCase {

  func testInit() throws {
    // Arrange
    let compositionType = CompositionType.entrance
    let selectedFigure: Binding<Figure?> = .constant(.init(title: "figure"))
    let repository = FakeAcrobaticRepository()

    // Act
    let viewModel = CompositionListViewModel(
      compositionType: compositionType,
      selectedFigure: selectedFigure,
      acrobaticRepository: repository)

    // Assert
    XCTAssertNotNil(viewModel.figures)

  }

}
