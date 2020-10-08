//
//  TerminalStylePresets.swift
//  
//
//  Created by Justin Reusch on 10/7/20.
//

import Foundation

extension TerminalStyle {
    
    // Preset styles ---------------------------------------- /
     
    // No color / Reset --- /
    public static let noColor: Self = Self()
    public static let reset: Self = Self()
    
    // Normal --- /
    public static let black: Self = Self(effects: [.normal], foreground: .black)
    public static let red: Self = Self(effects: [.normal], foreground: .red)
    public static let green: Self = Self(effects: [.normal], foreground: .green)
    public static let yellow: Self = Self(effects: [.normal], foreground: .yellow)
    public static let blue: Self = Self(effects: [.normal], foreground: .blue)
    public static let magenta: Self = Self(effects: [.normal], foreground: .magenta)
    public static let cyan: Self = Self(effects: [.normal], foreground: .cyan)
    public static let white: Self = Self(effects: [.normal], foreground: .white)
    
    // Bold and Bright --- /
    public static let brightBlack: Self = Self(effects: [.bold], foreground: .brightBlack)
    public static let brightRed: Self = Self(effects: [.bold], foreground: .brightRed)
    public static let brightGreen: Self = Self(effects: [.bold], foreground: .brightGreen)
    public static let brightYellow: Self = Self(effects: [.bold], foreground: .brightYellow)
    public static let brightBlue: Self = Self(effects: [.bold], foreground: .brightBlue)
    public static let brightMagenta: Self = Self(effects: [.bold], foreground: .brightMagenta)
    public static let brightCyan: Self = Self(effects: [.bold], foreground: .brightCyan)
    public static let brightWhite: Self = Self(effects: [.bold], foreground: .brightWhite)
    
    // Italic --- /
    public static let italicBlack: Self = Self(effects: [.italic], foreground: .black)
    public static let italicRed: Self = Self(effects: [.italic], foreground: .red)
    public static let italicGreen: Self = Self(effects: [.italic], foreground: .green)
    public static let italicYellow: Self = Self(effects: [.italic], foreground: .yellow)
    public static let italicBlue: Self = Self(effects: [.italic], foreground: .blue)
    public static let italicMagenta: Self = Self(effects: [.italic], foreground: .magenta)
    public static let italicCyan: Self = Self(effects: [.italic], foreground: .cyan)
    public static let italicWhite: Self = Self(effects: [.italic], foreground: .white)
    
    // Backgrounds --- /
    public static let redBackground: Self = Self(effects: [.bold], foreground: .brightWhite, background: .red)
    public static let blueBackground: Self = Self(effects: [.bold], foreground: .brightWhite, background: .blue)
    public static let greenBackground: Self = Self(effects: [.normal], foreground: .black, background: .green)
    public static let yellowBackground: Self = Self(effects: [.normal], foreground: .black, background: .brightYellow)
    
    // Misc. --- /
    public static let normalBrightYellow: Self = Self(effects: [.normal], foreground: .brightYellow)
    public static let blink: Self = Self(effects: [.slowBlink])
    
}

// Reference ------------------------------------------------------------------------------------------------ /

// Source: https://stackoverflow.com/a/5947802/3055803

// ANSI Escape Codes:
// ---------------------------------------- /
// Black        0;30     Dark Gray     1;30
// Red          0;31     Light Red     1;31
// Green        0;32     Light Green   1;32
// Brown/Orange 0;33     Yellow        1;33
// Blue         0;34     Light Blue    1;34
// Purple       0;35     Light Purple  1;35
// Cyan         0;36     Light Cyan    1;36
// Light Gray   0;37     White         1;37

// ---------------------------------------- /
// RED='\033[0;31m'
// NC='\033[0m' # No Color
// printf "I ${RED}love${NC} Stack Overflow\n"

// Source: https://stackoverflow.com/q/40583721/3055803

// let redColor = "\u{001B}[0;31m"
// let message = "Some Message"
// print(redColor + message)
// print("\(redColor)\(message)")
