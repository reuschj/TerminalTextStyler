//
//  Highlight.swift
//  
//
//  Created by Justin Reusch on 10/4/20.
//

import Foundation

/// Highlights the given text in the requested terminal color, (defaulting to bright yellow).
/// - Parameter text: The content to highlight
/// - Parameter style: The terminal style to highlight with.
/// - Returns: An instance of `StyledTerminalText` to add to `String` output
public func highlight<Content: StringProtocol>(_ text: Content, with style: TerminalStyle = .brightYellow) -> StyledTerminalText { StyledTerminalText(text, style: style) }

// Convenience functions for each preset color
public func highlightBlack<Content: StringProtocol>(_ text: Content) -> StyledTerminalText { StyledTerminalText(text, style: .black) }
public func highlightRed<Content: StringProtocol>(_ text: Content) -> StyledTerminalText { StyledTerminalText(text, style: .red) }
public func highlightGreen<Content: StringProtocol>(_ text: Content) -> StyledTerminalText { StyledTerminalText(text, style: .green) }
public func highlightYellow<Content: StringProtocol>(_ text: Content) -> StyledTerminalText { StyledTerminalText(text, style: .yellow) }
public func highlightBlue<Content: StringProtocol>(_ text: Content) -> StyledTerminalText { StyledTerminalText(text, style: .blue) }
public func highlightMagenta<Content: StringProtocol>(_ text: Content) -> StyledTerminalText { StyledTerminalText(text, style: .magenta) }
public func highlightCyan<Content: StringProtocol>(_ text: Content) -> StyledTerminalText { StyledTerminalText(text, style: .cyan) }
public func highlightWhite<Content: StringProtocol>(_ text: Content) -> StyledTerminalText { StyledTerminalText(text, style: .white) }
// Bright and Bold
public func highlightBrightBlack<Content: StringProtocol>(_ text: Content) -> StyledTerminalText { StyledTerminalText(text, style: .brightBlack) }
public func highlightBrightRed<Content: StringProtocol>(_ text: Content) -> StyledTerminalText { StyledTerminalText(text, style: .brightRed) }
public func highlightBrightGreen<Content: StringProtocol>(_ text: Content) -> StyledTerminalText { StyledTerminalText(text, style: .brightGreen) }
public func highlightBrightYellow<Content: StringProtocol>(_ text: Content) -> StyledTerminalText { StyledTerminalText(text, style: .brightYellow) }
public func highlightBrightBlue<Content: StringProtocol>(_ text: Content) -> StyledTerminalText { StyledTerminalText(text, style: .brightBlue) }
public func highlightBrightPurple<Content: StringProtocol>(_ text: Content) -> StyledTerminalText { StyledTerminalText(text, style: .brightMagenta) }
public func highlightBrightCyan<Content: StringProtocol>(_ text: Content) -> StyledTerminalText { StyledTerminalText(text, style: .brightCyan) }
public func highlightBrightWhite<Content: StringProtocol>(_ text: Content) -> StyledTerminalText { StyledTerminalText(text, style: .brightWhite) }
