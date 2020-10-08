//
//  ANSIBackgroundColor.swift
//  
//
//  Created by Justin Reusch on 10/8/20.
//

import Foundation

/// ANSI Escape codes for text background color.
/// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
public enum ANSIBackgroundColor: Coded, CustomStringConvertible, Equatable {
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
        case .black: return 40
        case .red: return 41
        case .green: return 42
        case .yellow: return 43
        case .blue: return 44
        case .magenta: return 45
        case .cyan: return 46
        case .white: return 47
        case .brightBlack: return 100
        case .brightRed: return 101
        case .brightGreen: return 102
        case .brightYellow: return 103
        case .brightBlue: return 104
        case .brightMagenta: return 105
        case .brightCyan: return 106
        case .brightWhite: return 107
        case .ansi256(_): return 48
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
    /// - Parameter ansi256: Specify an optional ANSI 256-color code (hint: only relevant when primary code is 48)
    public static func from(code: UInt8, ansi256: UInt8? = nil) -> Self? {
        switch code {
        case 40: return .black
        case 41: return .red
        case 42: return .green
        case 43: return .yellow
        case 44: return .blue
        case 45: return .magenta
        case 46: return .cyan
        case 47: return .white
        case 100: return .brightBlack
        case 101: return .brightRed
        case 102: return .brightGreen
        case 103: return .brightYellow
        case 104: return .brightBlue
        case 105: return .brightMagenta
        case 106: return .brightCyan
        case 107: return .brightWhite
        case 48:
            guard let ansi256 = ansi256 else { return nil }
            return .ansi256(ansi256)
        default: return nil
        }
    }
}
