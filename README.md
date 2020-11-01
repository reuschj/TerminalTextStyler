# TerminalTextStyler

If you are building a command-line tool with Swift, you may find it useful to highlight output in a style to make it stand out. Doing so, simply means wrapping your text in the necessary [ANSI escape codes](https://en.wikipedia.org/wiki/ANSI_escape_code).

ANSI Color | Normal | Bold | With Background
---- | ---- | ----  | ----
Black | 0;30 | 1;30 | 0;40
Red | 0;31 | 1;31 | 0;41
Green | 0;32 | 1;31 | 0;42
Yellow | 0;33 | 1;31 | 0;43
Blue | 0;34 | 1;31 | 0;44
Magenta | 0;35 | 1;31 | 0;45
Cyan | 0;36 | 1;31 | 0;46
White | 0;37 | 1;31 | 0;47
Bright Black | 0;90 | 1;31 | 0;100
Bright Red | 0;91 | 1;31 | 0;101
Bright Green | 0;92 | 1;31 | 0;102
Bright Yellow | 0;93 | 1;31 | 0;103
Bright Blue | 0;94 | 1;31 | 0;104
Bright Purple | 0;95 | 1;95 | 0;105
Bright Cyan | 0;96 | 1;96 | 0;106
Bright White | 0;97 | 1;97 | 0;107

For example:

```
RED='\033[0;31m'
NC='\033[0m' # No Color
printf "I ${RED}love${NC} Stack Overflow\n"
```
Source: [StackOverflow](https://stackoverflow.com/a/5947802/3055803)

In Swift, we can just replace `'\033'` with the unicode `"\u{001B}"` (Source: [StackOverflow](https://stackoverflow.com/q/40583721/3055803)).

So, we can switch to the desired color by placing the escape code to start that color in our text and end it by using the escape code for no color. That's all there is to it! So, to highlight our text in yellow, we can just do this:

```swift
print("\u{001B}[0;31mHello, World!\u{001B}[0m")
```

But, that's kinda clunky and hard to read. That's where this package comes in.

## TerminalStyle

With the `TerminalStyle` struct, we can build a color by giving the ANSI escape codes or building out styles with the supplied enums.

```swift
// Manual with codes
let yellowManual = TerminalStyle(codes: [0, 93])

// Using enums
let yellow = TerminalStyle(styles: [.normal], foreground: .brightYellow)
let noColor = TerminalStyle() // Initialize without input parameters for no color
```

Now, when placed in a string (or by accessing the `command` property), a `TerminalStyle` instance will generate the ANSI escape code string:

```swift
let yellow = TerminalStyle(styles: [.normal], foreground: .brightYellow)
let noColor = TerminalStyle()
print("\(yellow)Hello, World!\(noColor)")
```

This is much better, but we can make it a bit easier. We can call the `wrap` method to wrap the given text in that color.

```swift
let yellow = TerminalStyle(styles: [.normal], foreground: .brightYellow)
print(yellow.wrap("Hello, World!"))
// Or
print("\(yellow.wrap("Hello, World!")) Blah blah blah...")
```

### Presets

For your convenience, `TerminalStyle` comes in with some static presets:

```swift
let yellow = TerminalStyle.brightYellow
let red = TerminalStyle.red
// Etc...
```

## StyledTerminalText

The `StyledTerminalText` struct builds on the `wrap` command to put the emphasis back on your text, not the color. The `StyledTerminalText` instance can then be placed right into a `String` (or turned into a `String` by accessing the `output` property):

```swift
let greeting = StyledTerminalText("Hello, World!", style: .brightYellow)
print("\(greeting) Blah blah blah...")
```

## Highlight Function(s)

The last step to making your code clean and easy is by just using the `highlight` convenience function to generate a `StyledTerminalText`:

```swift
print("\(highlight("Hello, World!", with: .brightYellow)) Blah blah blah...")
// Or, because `highlight` defaults to .brightYellow:
print("\(highlight("Hello, World!")) Blah blah blah...")
```

Each style in the table above also has a unique highlight function:

```swift
print("This is \(highlightBrightYellow("highlighted in bright yellow")) and this is \(highlightRed("highlighted in red")).")
```
