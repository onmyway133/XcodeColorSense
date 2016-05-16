//
//  Regex.swift
//  XcodeColorSense
//
//  Created by Khoa Pham on 16/05/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

struct Regex {

  static func validate(string: String, pattern: String) -> Bool {
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    return regex?.firstMatchInString(string, options: [], range: NSMakeRange(0, string.characters.count)) != nil
  }

  static func validateHex(string: String) -> Bool {
    let pattern = "^#?[A-Fa-f0-9]{6}$"
    return validate(string, pattern: pattern)
  }
}
