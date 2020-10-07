//
//  TerminalStylePresets.swift
//  
//
//  Created by Justin Reusch on 10/7/20.
//

import Foundation

extension TerminalStyle {
    
    // Preset colors ---------------------------------------- /
    
    public static let noColor: Self = Self()
    public static let black: Self = Self(styles: [.normal], foreground: .black)
    public static let red: Self = Self(styles: [.normal], foreground: .red)
    public static let green: Self = Self(styles: [.normal], foreground: .green)
    public static let yellow: Self = Self(styles: [.normal], foreground: .yellow)
    public static let blue: Self = Self(styles: [.normal], foreground: .blue)
    public static let magenta: Self = Self(styles: [.normal], foreground: .magenta)
    public static let cyan: Self = Self(styles: [.normal], foreground: .cyan)
    public static let lightGray: Self = Self(styles: [.normal], foreground: .lightGray)
    public static let darkGray: Self = Self(styles: [.bold], foreground: .darkGray)
    public static let brightRed: Self = Self(styles: [.bold], foreground: .brightRed)
    public static let brightGreen: Self = Self(styles: [.bold], foreground: .brightGreen)
    public static let brightYellow: Self = Self(styles: [.bold], foreground: .brightYellow)
    public static let brightBlue: Self = Self(styles: [.bold], foreground: .brightBlue)
    public static let brightPurple: Self = Self(styles: [.bold], foreground: .brightMagenta)
    public static let brightCyan: Self = Self(styles: [.bold], foreground: .brightCyan)
    public static let white: Self = Self(styles: [.bold], foreground: .white)
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
