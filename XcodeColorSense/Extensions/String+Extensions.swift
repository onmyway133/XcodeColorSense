//
//  String+Extensions.swift
//  XcodeColorSense
//
//  Created by Khoa Pham on 17/05/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

extension String {
  
  func contains(string: String) -> Bool {
    return rangeOfString(string, options: .CaseInsensitiveSearch) != nil
  }

  func replace(occurence: String, with: String) -> String {
    return stringByReplacingOccurrencesOfString(occurence, withString: with)
  }

  func remove(occurrence: String) -> String {
    return replace(occurrence, with: "")
  }

  func trim() -> String {
    return stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
  }
}
