//
//  SGREffect.swift
//  
//
//  Created by Justin Reusch on 10/8/20.
//

import Foundation

/// SGR (Select Graphic Rendition) sets display attributes.
/// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
public enum SGREffect: Coded, CustomStringConvertible, Equatable {
    case normal
    case bold
    case faint
    case italic
    case underline
    case slowBlink
    case rapidBlink
    case crossedOut
    case byCode(UInt8)
    
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
        case .byCode(let code): return code
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
        case .byCode(let code): return "SGR Code \(code)"
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
        default: return .byCode(code)
        }
    }
}
