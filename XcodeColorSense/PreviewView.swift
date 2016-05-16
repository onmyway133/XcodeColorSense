//
//  PreviewView.swift
//  XcodeColorSense
//
//  Created by Khoa Pham on 16/05/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Cocoa

class PreviewView: NSView {

  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  var color: NSColor = .clearColor() {
    didSet {
      setNeedsDisplayInRect(bounds)
    }
  }

  override func drawRect(dirtyRect: NSRect) {
    color.setStroke()

    NSBezierPath.strokeRect(NSInsetRect(bounds, 0.5, 0.5))
  }
}
