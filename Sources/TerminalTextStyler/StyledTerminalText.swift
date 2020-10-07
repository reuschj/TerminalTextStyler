//
//  StyledTerminalText.swift
//  
//
//  Created by Justin Reusch on 10/4/20.
//

import Foundation

/// Holds and displays text that will print with the specified color in a terminal.
public struct StyledTerminalText {
    public var text: String {
        didSet { updateOutput() }
    }
    public var style: TerminalStyle {
        didSet { updateOutput() }
    }
    
    /// The generated output string for terminal
    public private(set) var output: String!
    
    public init<Content: StringProtocol>(_ text: Content, style: TerminalStyle = .noColor) {
        self.output = nil
        self.text = String(text)
        self.style = style
        self.updateOutput()
    }
    
    /// Generates the output
    private mutating func updateOutput() {
        self.output = self.style.wrap(self.text)
    }
}

extension StyledTerminalText: CustomStringConvertible {
    
    /// String representation of terminal command code.
    public var description: String { self.output }
}

extension StyledTerminalText: Equatable {
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.text == rhs.text && lhs.style == rhs.style
    }
}
