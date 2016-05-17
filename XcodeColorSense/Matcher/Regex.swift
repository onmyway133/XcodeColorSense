//
//  Regex.swift
//  XcodeColorSense
//
//  Created by Khoa Pham on 16/05/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

struct Regex {

  static func check(string: String, pattern: String) -> NSRange? {
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    return regex?.firstMatchInString(string, options: [], range: NSMakeRange(0, string.characters.count))?.range
  }
}
