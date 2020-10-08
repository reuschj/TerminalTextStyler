//
//  ANSIForegroundColor.swift
//  
//
//  Created by Justin Reusch on 10/8/20.
//

import Foundation

/// ANSI Escape codes for text foreground color.
/// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
public enum ANSIForegroundColor: Coded, CustomStringConvertible, Equatable {
    case black
    case red
    case green
    case yellow
    case blue
    case magenta
    case cyan
    case white
    case brightBlack
    case brightRed
    case brightGreen
    case brightYellow
    case brightBlue
    case brightMagenta
    case brightCyan
    case brightWhite
    case ansi256(UInt8)
    
    /// ANSI escape code
    public var code: UInt8 {
        switch self {
        case .black: return 30
        case .red: return 31
        case .green: return 32
        case .yellow: return 33
        case .blue: return 34
        case .magenta: return 35
        case .cyan: return 36
        case .white: return 37
        case .brightBlack: return 90
        case .brightRed: return 91
        case .brightGreen: return 92
        case .brightYellow: return 93
        case .brightBlue: return 94
        case .brightMagenta: return 95
        case .brightCyan: return 96
        case .brightWhite: return 97
        case .ansi256(_): return 38
        }
    }
    
    /// ANSI escape code
    public var additionalCodes: [UInt8]? {
        switch self {
        case .ansi256(let ansiCode): return [5, ansiCode]
        default: return nil
        }
    }
    
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
        case .white: return "white"
        case .brightBlack: return "brightBlack"
        case .brightRed: return "brightRed"
        case .brightGreen: return "brightGreen"
        case .brightYellow: return "brightYellow"
        case .brightBlue: return "brightBlue"
        case .brightMagenta: return "brightMagenta"
        case .brightCyan: return "brightCyan"
        case .brightWhite: return "brightWhite"
        case .ansi256(let ansiCode): return "ANSI 256-color (\(ansiCode))"
        }
    }
    
    /// Makes a new instance from ANSI escape code
    /// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
    /// - Parameter code: Primary ANSI code
    /// - Parameter ansi256: Specify an optional ANSI 256-color code (hint: only relevant when primary code is 38)
    public static func from(code: UInt8, ansi256: UInt8? = nil) -> Self? {
        switch code {
        case 30: return .black
        case 31: return .red
        case 32: return .green
        case 33: return .yellow
        case 34: return .blue
        case 35: return .magenta
        case 36: return .cyan
        case 37: return .white
        case 90: return .brightBlack
        case 91: return .brightRed
        case 92: return .brightGreen
        case 93: return .brightYellow
        case 94: return .brightBlue
        case 95: return .brightMagenta
        case 96: return .brightCyan
        case 97: return .brightWhite
        case 38:
            guard let ansi256 = ansi256 else { return nil }
            return .ansi256(ansi256)
        default: return nil
        }
    }
}
