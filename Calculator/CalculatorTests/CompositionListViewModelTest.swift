import SwiftUI
import XCTest
@testable import Calculator

final class CompositionListViewModelTest: XCTestCase {

  // MARK: Internal

  func testInit() throws {
    // Arrange
    let compositionType = CompositionType.entrance
    let selectedFigure: Binding<Figure?> = .constant(.init(title: "figure"))
    let repository = FakeAcrobaticRepository()

    // Act
    let viewModel = CompositionListViewModel(
      compositionType: compositionType,
      acrobaticGroup: .forward,
      selectedFigure: selectedFigure,
      acrobaticRepository: repository)

    // Assert
    XCTAssertNotNil(viewModel.figures)

  }

  func testOnViewAppearForEntrance() {
    assertOnViewAppear(for: .entrance, figuresExpectation: FakeAcrobaticRepository.entrancesSample)
  }

  func testOnViewAppearForFirstFigure() {
    assertOnViewAppear(for: .firstFigure, figuresExpectation: FakeAcrobaticRepository.figuresSample)
  }

  func testOnViewAppearForLanding() {
    assertOnViewAppear(for: .landing, figuresExpectation: FakeAcrobaticRepository.landingSample)
  }

  @MainActor
  func testDidSelectFigure() async {
    // Arrange
    let viewModel = CompositionListViewModel(
      compositionType: .entrance,
      acrobaticGroup: .forward,
      selectedFigure: .constant(Figure(title: "figure")),
      acrobaticRepository: FakeAcrobaticRepository())
    let selectedFigure = Figure(title: "figure")

    // Act
    viewModel.didSelectFigure(selectedFigure)

    await Task.yield()

    // Assert
    XCTAssertEqual(selectedFigure, viewModel.selectedFigure)
  }

  @MainActor
  func testIsFigureSelected() async {
    // Arrange
    let viewModel = CompositionListViewModel(
      compositionType: .entrance,
      acrobaticGroup: .forward,
      selectedFigure: .constant(Figure(title: "figure")),
      acrobaticRepository: FakeAcrobaticRepository())
    let selectedFigure = Figure(title: "figure")
    viewModel.didSelectFigure(selectedFigure)
    await Task.yield()

    // Act and Assert 1
    let isFigureSelected = viewModel.isFigureSelected(selectedFigure)
    XCTAssertTrue(isFigureSelected)

    // Act and Assert 2
    let anotherFigure = Figure(title: "figure2")
    let isAnotherFigureSelected = viewModel.isFigureSelected(anotherFigure)
    XCTAssertFalse(isAnotherFigureSelected)
  }

  // MARK: Private

  private func assertOnViewAppear(for compositionType: CompositionType, figuresExpectation: [Figure]) {
    // Arrange
    let repository = FakeAcrobaticRepository()
    let viewModel = CompositionListViewModel(
      compositionType: compositionType,
      acrobaticGroup: .forward,
      selectedFigure: .constant(Figure(title: "figure")),
      acrobaticRepository: repository)

    // Act
    viewModel.onViewAppear()

    // Assert
    XCTAssertEqual(figuresExpectation, viewModel.figures)
  }

}
