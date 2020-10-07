//
//  TerminalStyle.swift
//
//
//  Created by Justin Reusch on 10/4/20.
//

import Foundation

/// Stores a custom color for terminal fonts.
/// This creates the escape command to change terminal
/// font color.
/// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
public struct TerminalStyle {
    public private(set) var codes: [UInt8]? = nil
    
    public private(set) var command: String
    
    /// Gets a list of all styles applied to
    public var styles: [SGR]? {
        guard let codes = codes else { return nil }
        return codes.map { SGR.from(code: $0) }
    }
    
    public var foreground: ForegroundColor? {
        guard let codes = codes else { return nil }
        for code in codes {
            if let foreground = ForegroundColor.from(code: code) {
                return foreground as ForegroundColor
            }
        }
        return nil
    }
    
    public var background: BackgroundColor? {
        guard let codes = codes else { return nil }
        for code in codes {
            if let background = BackgroundColor.from(code: code) {
                return background as BackgroundColor
            }
        }
        return nil
    }
    
    // Init ------------------------------------------------------------------------------ /
    
    /// Init with individual escape codes.
    public init(codes: [UInt8]) {
        self.codes = codes.isEmpty ? nil : codes
        self.command = Self.makeCommand(codes: codes)
    }
    
    /// Init with individual escape codes.
    public init(
        styles: [SGR]? = nil,
        foreground: ForegroundColor? = nil,
        background: BackgroundColor? = nil
    ) {
        var codes: [UInt8] = []
        if let foreground = foreground {
            codes.append(foreground.code)
        }
        if let background = background {
            codes.append(background.code)
        }
        if let styles = styles {
            styles.forEach { codes.append($0.code) }
        }
        self.codes = codes.isEmpty ? nil : codes
        self.command = Self.makeCommand(codes: self.codes)
    }
    
    // Instance methods ------------------------------------------------------------------------------ /
    
    /// Wraps given text with an ANSI escape code command to start the custom color at the beginning and ends
    /// the string with a no-color command.
    public func wrap<Content: StringProtocol>(_ content: Content) -> String { "\(command)\(content)\(Self.noColor)" }
    
    /// This formats the ANSI escape code string that switches the terminal color.
    private static func makeCommand(codes: [UInt8]?) -> String {
        let code = codes.map { codeList in codeList.map { "\($0)" }.joined(separator: ";") } ?? "\(0)"
        return "\u{001B}[\(code)m"
    }
    
    private static func getCoded(code: UInt8) -> Coded {
        if let foreground = ForegroundColor.from(code: code) {
            return foreground as ForegroundColor
        }
        if let background = BackgroundColor.from(code: code) {
            return background as BackgroundColor
        }
        return SGR.from(code: code) as SGR
    }
    
    // Enums ------------------------------------------------------------------ /
    
    /// SGR (Select Graphic Rendition) sets display attributes.
    /// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
    public enum SGR: Coded, CustomStringConvertible {
        case normal
        case bold
        case faint
        case italic
        case underline
        case slowBlink
        case rapidBlink
        case crossedOut
        case other(UInt8)
        
        /// ANSI escape code
        public var code: UInt8 {
            switch self {
            case .normal: return 0
            case .bold: return 1
            case .faint: return 2
            case .italic: return 3
            case .underline: return 4
            case .slowBlink: return 5
            case .rapidBlink: return 6
            case .crossedOut: return 9
            case .other(let code): return code
            }
        }
        
        /// String representation
        public var description: String {
            switch self {
            case .normal: return "normal/reset"
            case .bold: return "bold"
            case .faint: return "faint"
            case .italic: return "italic"
            case .underline: return "underline"
            case .slowBlink: return "slow blink"
            case .rapidBlink: return "rapid blink"
            case .crossedOut: return "crossed-out"
            case .other(let code): return "SGR Code \(code)"
            }
        }
        
        /// Makes a new instance from ANSI escape code
        /// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
        public static func from(code: UInt8) -> Self {
            switch code {
            case 0: return .normal
            case 1: return .bold
            case 2: return .faint
            case 3: return .italic
            case 4: return .underline
            case 5: return .slowBlink
            case 6: return .rapidBlink
            case 9: return .crossedOut
            default: return .other(code)
            }
        }
    }
    
    // ------------------------------ /
    
    /// ANSI Escape codes for text foreground color.
    /// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
    public enum ForegroundColor: UInt8, Coded, CustomStringConvertible {
        case black = 30
        case red = 31
        case green = 32
        case yellow = 33
        case blue = 34
        case magenta = 35
        case cyan = 36
        case lightGray = 37
        case darkGray = 90
        case brightRed = 91
        case brightGreen = 92
        case brightYellow = 93
        case brightBlue = 94
        case brightMagenta = 95
        case brightCyan = 96
        case white = 97
        
        /// ANSI escape code
        public var code: UInt8 { rawValue }
        
        /// String representation
        public var description: String {
            switch self {
            case .black: return "black"
            case .red: return "red"
            case .green: return "green"
            case .yellow: return "yellow"
            case .blue: return "blue"
            case .magenta: return "magenta"
            case .cyan: return "cyan"
            case .lightGray: return "lightGray"
            case .darkGray: return "darkGray"
            case .brightRed: return "brightRed"
            case .brightGreen: return "brightGreen"
            case .brightYellow: return "brightYellow"
            case .brightBlue: return "brightBlue"
            case .brightMagenta: return "brightMagenta"
            case .brightCyan: return "brightCyan"
            case .white: return "white"
            }
        }
        
        /// Makes a new instance from ANSI escape code
        /// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
        public static func from(code: UInt8) -> Self? {
            switch code {
            case 30: return .black
            case 31: return .red
            case 32: return .green
            case 33: return .yellow
            case 34: return .blue
            case 35: return .magenta
            case 36: return .cyan
            case 37: return .lightGray
            case 90: return .darkGray
            case 91: return .brightRed
            case 92: return .brightGreen
            case 93: return .brightYellow
            case 94: return .brightBlue
            case 95: return .brightMagenta
            case 96: return .brightCyan
            case 97: return .white
            default: return nil
            }
        }
    }
    
    // ------------------------------ /
    
    /// ANSI Escape codes for text background color.
    /// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
    public enum BackgroundColor: UInt8, Coded, CustomStringConvertible {
        case black = 40
        case red = 41
        case green = 42
        case yellow = 43
        case blue = 44
        case magenta = 45
        case cyan = 46
        case lightGray = 47
        case darkGray = 100
        case brightRed = 101
        case brightGreen = 102
        case brightYellow = 103
        case brightBlue = 104
        case brightMagenta = 105
        case brightCyan = 106
        case white = 107
        
        /// ANSI escape code
        public var code: UInt8 { rawValue }
        
        /// String representation
        public var description: String {
            switch self {
            case .black: return "black"
            case .red: return "red"
            case .green: return "green"
            case .yellow: return "yellow"
            case .blue: return "blue"
            case .magenta: return "magenta"
            case .cyan: return "cyan"
            case .lightGray: return "lightGray"
            case .darkGray: return "darkGray"
            case .brightRed: return "brightRed"
            case .brightGreen: return "brightGreen"
            case .brightYellow: return "brightYellow"
            case .brightBlue: return "brightBlue"
            case .brightMagenta: return "brightMagenta"
            case .brightCyan: return "brightCyan"
            case .white: return "white"
            }
        }
        
        /// Makes a new instance from ANSI escape code
        /// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
        public static func from(code: UInt8) -> Self? {
            switch code {
            case 30: return .black
            case 31: return .red
            case 32: return .green
            case 33: return .yellow
            case 34: return .blue
            case 35: return .magenta
            case 36: return .cyan
            case 37: return .lightGray
            case 90: return .darkGray
            case 91: return .brightRed
            case 92: return .brightGreen
            case 93: return .brightYellow
            case 94: return .brightBlue
            case 95: return .brightMagenta
            case 96: return .brightCyan
            case 97: return .white
            default: return nil
            }
        }
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
