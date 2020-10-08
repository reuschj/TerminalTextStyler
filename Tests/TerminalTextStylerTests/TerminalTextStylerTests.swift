import XCTest
@testable import TerminalTextStyler

final class TerminalTextStylerTests: XCTestCase {
    let manual = TerminalStyle(codes: [0,33,41])
    let yellow = TerminalStyle(effects: [.bold], foreground: .brightYellow)
    let yellowWithBackground = TerminalStyle(effects: [.normal], foreground: .yellow, background: .red)
    let multiStyle = TerminalStyle(effects: [.bold, .italic, .slowBlink], foreground: .blue)
    let multiStyle02 = TerminalStyle(effects: [.bold, .italic, .slowBlink], background: .white)
    let multiStyle03 = TerminalStyle(effects: [.bold, .italic, .slowBlink])
    let color256 = TerminalStyle(effects: [.bold], foreground: .ansi256(183), background: .ansi256(190))
    let noColor = TerminalStyle()
    
    func testThatCodeGeneratesCorrectly() {
        XCTAssertEqual(manual.command, "\u{001B}[0;33;41m")
        XCTAssertEqual(yellow.command, "\u{001B}[1;93m")
        XCTAssertEqual(yellowWithBackground.command, "\u{001B}[0;33;41m")
        XCTAssertEqual(multiStyle.command, "\u{001B}[1;3;5;34m")
        XCTAssertEqual(multiStyle02.command, "\u{001B}[1;3;5;47m")
        XCTAssertEqual(multiStyle03.command, "\u{001B}[1;3;5m")
        XCTAssertEqual(color256.command, "\u{001B}[1;38;5;183;48;5;190m")
        XCTAssertEqual(noColor.command, "\u{001B}[0m")
        XCTAssertEqual(manual, yellowWithBackground)
        XCTAssertEqual(yellow, TerminalStyle.brightYellow)
        XCTAssertEqual(noColor, TerminalStyle.noColor)
        XCTAssertEqual(noColor, TerminalStyle.reset)
        XCTAssertEqual(TerminalStyle.noColor, TerminalStyle.reset)
    }
    
    func testColorLookup() {
        XCTAssertEqual(yellow.foreground, ANSIForegroundColor.brightYellow)
        XCTAssertEqual(yellow.background, nil)
        XCTAssertEqual(yellowWithBackground.background, ANSIBackgroundColor.red)
    }
    
    func testStyleLookup() {
        XCTAssertEqual(yellow.styles?.count, 2)
        XCTAssertEqual(yellow.styles?[0], SGREffect.bold)
        XCTAssertEqual(yellow.styles?[1], SGREffect.byCode(93))
        XCTAssertEqual(multiStyle.styles?.count, 4)
        XCTAssertEqual(multiStyle03.styles?.count, 3)
    }
    
    func testThatContentCanBeWrapped() {
        let wrapped = yellow.wrap("Hello, World!")
        XCTAssertEqual(wrapped, "\u{001B}[1;93mHello, World!\u{001B}[0m")
        XCTAssertEqual(wrapped, "\(yellow)Hello, World!\(noColor)")
    }
    
    func testColorTerminalText() {
        let highlighted = StyledTerminalText("Hello, World!", style: .brightYellow)
        XCTAssertEqual(highlighted.output, "\u{001B}[1;93mHello, World!\u{001B}[0m")
        XCTAssertEqual("\(highlighted)", "\u{001B}[1;93mHello, World!\u{001B}[0m")
        XCTAssertEqual(highlight("Hello, World!", with: .brightYellow).output, "\u{001B}[1;93mHello, World!\u{001B}[0m")
    }
}
