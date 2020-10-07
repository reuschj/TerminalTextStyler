# TerminalTextStyler

If you are building a command-line tool with Swift, you may find it useful to highlight output in a style to make it stand out. Doing so, simply means wrapping your text in the necessary [ANSI escape codes](https://en.wikipedia.org/wiki/ANSI_escape_code). For example,

Color | ANSI Escape Code
---- | ----
Black | 0;30
Red | 0;31
Green | 0;32
Yellow | 0;33
Blue | 0;34
Purple | 0;35
Cyan | 0;36
Light Gray | 0;37
Dark Gray | 0;90
Bright Red | 0;91
Bright Green | 0;92
Bright Yellow | 0;93
Bright Blue | 0;94
Bright Purple | 0;95
Bright Cyan | 0;96
White | 0;97

Source: [StackOverflow](https://stackoverflow.com/a/5947802/3055803)

```
RED='\033[0;31m'
NC='\033[0m' # No Color
printf "I ${RED}love${NC} Stack Overflow\n"
```

In Swift, we can just replace '\033' with the unicode "\u{001B}" (Source: [StackOverflow](https://stackoverflow.com/q/40583721/3055803)).

So, we can switch to the desired color by placing the escape code to start that color in our text and end it by using the escape code for no color. That's all there is to it! So, to highlight our text in yellow, we can just do this:

```swift
print("\u{001B}[1;33mHello, World!\u{001B}[0m")
```

But, that's kinda clunky and hard to read. That's where this package comes in.

## TerminalStyle

With the `TerminalStyle` struct, we can build a color by giving it the two parts of the escape code combination from the table above.

```swift
let yellow = TerminalStyle(styles: [.normal], foreground: .yellow)
let noColor = TerminalColor() // Initialize without input parameters for no color
```

Now, when placed in a string (of by accessing the `command` property), a `TerminalStyle` instance will generate the ANSI escape code string:

```swift
let yellow = TerminalStyle(1, 33)
let noColor = TerminalStyle()
print("\(yellow)Hello, World!\(noColor)")
```

This is much better, but we can make it a bit easier. We can call the `wrap` method to wrap the given text in that color.

```swift
let yellow = TerminalStyle(1, 33)
print(yellow.wrap("Hello, World!"))
// Or
print("\(yellow.wrap("Hello, World!")) Blah blah blah...")
```

### Presets

For your convenience, all the colors in the table above can be accessed as static presets:

```swift
let yellow = TerminalStyle.yellow
let red = TerminalStyle.red
// Etc...
```

## StyledTerminalText

The `StyledTerminalText` struct builds on the `wrap` command to put the emphasis back on your text, not the color. The `StyledTerminalText` instance can then be placed right into a `String` (or turned into a `String` by accessing the `output` property):

```swift
let greeting = StyledTerminalText("Hello, World!", style: .yellow)
print("\(greeting) Blah blah blah...")
```

## Highlight Function(s)

The last step to making your code clean and easy is by just using the `highlight` convenience function to generate a `ColorTerminalText`:

```swift
print("\(highlight("Hello, World!", with: .yellow)) Blah blah blah...")
// Or, because `highlight` defaults to .yellow:
print("\(highlight("Hello, World!")) Blah blah blah...")
```

Each color in the table above also has a unique highlight function:

```swift
print("This is \(highlightYellow("highlighted in yellow")) and this is \(highlightRed("highlighted in red")).")
```
