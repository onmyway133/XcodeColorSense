XcodeColorSense
==
An Xcode plugin that makes working with color easier. Inspired by [ColorSense-for-Xcode](https://github.com/omz/ColorSense-for-Xcode) with extra care for Hex color

![](Screenshots/Banner.png)

Features
==

- Works for `UIColor`, `NSColor`

![](Screenshots/XcodeColorSense.png)

## Matchers

- Hex Matcher
- Red-Green-Blue-Alpha Matcher

## Extensible

Add your own color handler by conforming to `Matcher`

```swift
protocol Matcher {
  func check(line: String, selectedText: String) -> (color: NSColor, range: NSRange)?
}
```

Licence
--
This project is released under the MIT license. See LICENSE.md.
