import Foundation

public class AcrobaticListViewModel: ObservableObject {

  // MARK: Lifecycle

  public init(nbOfAcrobatics: Int) {
    self.nbOfAcrobatics = nbOfAcrobatics
  }

  public convenience init() {
    self.init(nbOfAcrobatics: 6)
  }

  // MARK: Internal

  let nbOfAcrobatics: Int

}
