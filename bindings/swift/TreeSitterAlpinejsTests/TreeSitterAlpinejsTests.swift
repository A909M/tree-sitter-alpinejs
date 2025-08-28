import XCTest
import SwiftTreeSitter
import TreeSitterAlpinejs

final class TreeSitterAlpinejsTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_alpinejs())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading Alpinejs grammar")
    }
}
