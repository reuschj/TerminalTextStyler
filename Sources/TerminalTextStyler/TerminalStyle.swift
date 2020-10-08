//
//  TerminalStyle.swift
//
//
//  Created by Justin Reusch on 10/4/20.
//

import Foundation

/// Stores a custom style for terminal text.
/// This creates the escape command needed to change terminal text color.
/// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
public struct TerminalStyle {
    /// List of raw ANSI SGR escape codes used to build the style
    public private(set) var codes: [UInt8]? = nil
    
    /// The built command string with escape code
    public private(set) var command: String
    
    /// Gets a list of all applied SGR effect styles
    public var styles: [SGREffect]? {
        guard let codes = codes else { return nil }
        return codes.map { SGREffect.from(code: $0) }
    }
    
    /// Looks up the foreground color (Note: This is not supported for ANSI 256-colors and will return `nil`)
    public var foreground: ANSIForegroundColor? {
        guard let codes = codes else { return nil }
        for code in codes {
            if let foreground = ANSIForegroundColor.from(code: code) {
                return foreground as ANSIForegroundColor
            }
        }
        return nil
    }
    
    /// Looks up the background color (Note: This is not supported for ANSI 256-colors and will return `nil`)
    public var background: ANSIBackgroundColor? {
        guard let codes = codes else { return nil }
        for code in codes {
            if let background = ANSIBackgroundColor.from(code: code) {
                return background as ANSIBackgroundColor
            }
        }
        return nil
    }
    
    // Init ------------------------------------------------------------------------------ /
    
    /// Init with individual escape codes.
    public init(codes: [UInt8]) {
        self.codes = codes.isEmpty ? nil : codes
        self.command = Self.makeCommand(codes: self.codes)
    }
    
    /// Init by building style and color options from enums
    public init(
        effects: [SGREffect]? = nil,
        foreground: ANSIForegroundColor? = nil,
        background: ANSIBackgroundColor? = nil
    ) {
        var codes: [UInt8] = []
        if let effects = effects {
            effects.forEach { codes.append($0.code) }
        }
        if let foreground = foreground {
            codes.append(foreground.code)
            switch foreground {
            case .ansi256(let ansi256):
                codes.append(5)
                codes.append(ansi256)
            default:
                break
            }
        }
        if let background = background {
            codes.append(background.code)
            switch background {
            case .ansi256(let ansi256):
                codes.append(5)
                codes.append(ansi256)
            default:
                break
            }
        }
        self.init(codes: codes)
    }
    
    // Instance methods ------------------------------------------------------------------------------ /
    
    /// Wraps given text with an ANSI escape code command to start the custom color at the beginning and ends
    /// the string with a no-color command.
    public func wrap<Content: StringProtocol>(_ content: Content) -> String { "\(command)\(content)\(Self.reset)" }
    
    // Private instance methods ------------------------------------------------------------------------------ /
    
    /// This formats the ANSI escape code string that switches the terminal color.
    private static func makeCommand(codes: [UInt8]?) -> String {
        let code = codes.map { codeList in codeList.map { "\($0)" }.joined(separator: ";") } ?? "\(0)"
        return "\u{001B}[\(code)m"
    }
}

extension TerminalStyle: CustomStringConvertible {
    
    /// String representation of terminal command code.
    public var description: String { command }
}

extension TerminalStyle: Equatable {
    
    public static func == (lhs: TerminalStyle, rhs: TerminalStyle) -> Bool {
        lhs.command == rhs.command
    }
}
