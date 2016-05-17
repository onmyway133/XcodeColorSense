//
//  PresetMatcher.swift
//  XcodeColorSense
//
//  Created by Khoa Pham on 17/05/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Cocoa

struct PresetMatcher: Matcher {

  func check(line: String, selectedText: String) -> (color: NSColor, range: NSRange)? {
    guard line.contains("UIColor") || line.contains("NSColor") else { return nil }

    let presets: [String: NSColor] = [
      "blackColor": .blackColor(),
      "darkGrayColor": .darkGrayColor(),
      "lightGrayColor": .lightGrayColor(),
      "whiteColor": .whiteColor(),
      "grayColor": .grayColor(),
      "redColor": .redColor(),
      "greenColor": .greenColor(),
      "blueColor": .blueColor(),
      "cyanColor": .cyanColor(),
      "yellowColor": .yellowColor(),
      "magentaColor": .magentaColor(),
      "orangeColor": .orangeColor(),
      "purpleColor": .purpleColor(),
      "brownColor": .brownColor(),
      "clearColor": .clearColor(),

      "controlShadowColor": .controlShadowColor(),
      "controlDarkShadowColor": .controlDarkShadowColor(),
      "controlColor": .controlColor(),
    ]

    for preset in presets {
      let range = (line as NSString).rangeOfString(preset.0)
      if range.location != NSNotFound {
        return (color: preset.1, range: range)
      }
    }

    return nil
  }
}
