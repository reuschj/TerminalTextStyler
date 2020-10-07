import XCTest
@testable import TerminalTextStyler

final class TerminalTextStylerTests: XCTestCase {
    let yellow = TerminalStyle(styles: [.bold], foreground: .brightYellow)
    let noColor = TerminalStyle()
    
    func testThatCodeGeneratesCorrectly() {
        XCTAssertEqual(yellow.command, "\u{001B}[93;1m")
        XCTAssertEqual(noColor.command, "\u{001B}[0m")
        XCTAssertEqual(yellow, TerminalStyle.brightYellow)
        XCTAssertEqual(noColor, TerminalStyle.noColor)
    }
    
    func testThatContentCanBeWrapped() {
        let wrapped = yellow.wrap("Hello, World!")
        XCTAssertEqual(wrapped, "\u{001B}[93;1mHello, World!\u{001B}[0m")
        XCTAssertEqual(wrapped, "\(yellow)Hello, World!\(noColor)")
    }
    
    func testColorTerminalText() {
        let highlighted = StyledTerminalText("Hello, World!", style: .brightYellow)
        XCTAssertEqual(highlighted.output, "\u{001B}[93;1mHello, World!\u{001B}[0m")
        XCTAssertEqual("\(highlighted)", "\u{001B}[93;1mHello, World!\u{001B}[0m")
        XCTAssertEqual(highlight("Hello, World!", with: .brightYellow).output, "\u{001B}[93;1mHello, World!\u{001B}[0m")
    }
}
