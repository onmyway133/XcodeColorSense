//
//  Matcher.swift
//  XcodeColorSense
//
//  Created by Khoa Pham on 17/05/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Cocoa

protocol Matcher {
  func check(line: String, selectedText: String) -> (color: NSColor, range: NSRange)?
}
