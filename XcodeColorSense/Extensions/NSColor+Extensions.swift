//
//  NSColor+Extensions.swift
//  XcodeColorSense
//
//  Created by Khoa Pham on 16/05/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Cocoa

extension NSColor {

  // https://github.com/hyperoslo/Hue/blob/master/Source/iOS/UIColor%2BHue.swift
  public static func hex(string: String) -> NSColor {
    var hex = string.hasPrefix("#")
      ? String(string.characters.dropFirst())
      : string

    guard hex.characters.count == 3 || hex.characters.count == 6
      else { return NSColor.whiteColor().colorWithAlphaComponent(0.0) }

    if hex.characters.count == 3 {
      for (index, char) in hex.characters.enumerate() {
        hex.insert(char, atIndex: hex.startIndex.advancedBy(index * 2))
      }
    }

    return NSColor(
      red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
      green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
      blue:  CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0, alpha: 1.0)
  }
}
