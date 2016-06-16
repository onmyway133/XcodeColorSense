//
//  HexMatcher.swift
//  XcodeColorSense
//
//  Created by Khoa Pham on 17/05/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Cocoa

public struct HexMatcher: Matcher {

  func check(line: String, selectedText: String) -> (color: NSColor, range: NSRange)? {
    let pattern1 = "\"#?[A-Fa-f0-9]{6}\""
    let pattern2 = "0x[A-Fa-f0-9]{6}"

    let ranges = [pattern1, pattern2].flatMap {
      return Regex.check(line, pattern: $0)
    }

    guard let range = ranges.first
      else { return nil }

    let text = (line as NSString).substringWithRange(range).replace("0x", with: "").replace("\"", with: "")
    let color = NSColor.hex(text)

    return (color: color, range: range)
  }
}
