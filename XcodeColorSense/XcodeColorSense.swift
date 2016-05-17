//
//  XcodeColorSense.swift
//
//  Created by Khoa Pham on 16/05/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import AppKit

var sharedPlugin: XcodeColorSense?

class XcodeColorSense: NSObject {

  var bundle: NSBundle
  lazy var center = NSNotificationCenter.defaultCenter()
  var textView: NSTextView?
  let previewView = PreviewView(frame: CGRect(origin: CGPointZero, size: CGSize(width: 60, height: 40)))
  let matchers: [Matcher] = [
    HexMatcher(),
    PresetMatcher(),
    RGBAMatcher(),
  ]

  // MARK: - Initialization

  class func pluginDidLoad(bundle: NSBundle) {
    let allowedLoaders = bundle.objectForInfoDictionaryKey("me.delisa.XcodePluginBase.AllowedLoaders") as! Array<String>
    if allowedLoaders.contains(NSBundle.mainBundle().bundleIdentifier ?? "") {
      sharedPlugin = XcodeColorSense(bundle: bundle)
    }
  }

  init(bundle: NSBundle) {
    self.bundle = bundle

    super.init()
    // NSApp may be nil if the plugin is loaded from the xcodebuild command line tool
    if (NSApp != nil && NSApp.mainMenu == nil) {
      center.addObserver(self, selector: #selector(self.applicationDidFinishLaunching), name: NSApplicationDidFinishLaunchingNotification, object: nil)
    } else {
      initializeAndLog()
    }
  }

  private func initializeAndLog() {
    let name = bundle.objectForInfoDictionaryKey("CFBundleName")
    let version = bundle.objectForInfoDictionaryKey("CFBundleShortVersionString")
    let status = initialize() ? "loaded successfully" : "failed to load"
    NSLog("🔌 Plugin \(name) \(version) \(status)")
  }

  func applicationDidFinishLaunching() {
    center.removeObserver(self, name: NSApplicationDidFinishLaunchingNotification, object: nil)
    initializeAndLog()
  }

  func initialize() -> Bool {
    findTextView()
    listenNotification()
    return true
  }

  func findTextView() {
    guard let DVTSourceTextView = NSClassFromString("DVTSourceTextView") as? NSObject.Type,
      firstResponder = NSApp.keyWindow?.firstResponder where firstResponder.isKindOfClass(DVTSourceTextView.self)
      else { return }

    textView = firstResponder as? NSTextView
  }

  // MARK: - Notification
  func listenNotification() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(handleSelectionChange(_:)), name: NSTextViewDidChangeSelectionNotification, object: nil)
  }

  func handleSelectionChange(note: NSNotification) {
    guard let DVTSourceTextView = NSClassFromString("DVTSourceTextView") as? NSObject.Type,
      object = note.object where object.isKindOfClass(DVTSourceTextView.self),
      let textView = object as? NSTextView
    else { return }

    self.textView = textView

    guard let range = textView.selectedRanges.first?.rangeValue,
      let string = textView.textStorage?.string
    else { return }

    // Text
    let text = string as NSString
    let selectedText = text.substringWithRange(range)
    let lineRange = text.lineRangeForRange(range)
    let line = text.substringWithRange(lineRange)

    // Match
    var result: (color: NSColor, range: NSRange)? = nil
    for matcher in matchers {
      if let r = matcher.check(line, selectedText: selectedText) {
        result = r
        break
      }
    }

    if let result = result {
      previewView.color = result.color
      textView.addSubview(previewView)

      // Position
      let foundRange = NSMakeRange(lineRange.location + result.range.location, result.range.length)
      let rectInScreen = textView.firstRectForCharacterRange(foundRange, actualRange: nil)
      let rectInWindow = textView.window?.convertRectFromScreen(rectInScreen) ?? NSZeroRect
      let rectInTextView = textView.convertRect(rectInWindow, fromView: nil)

      previewView.frame.origin = CGPoint(x: rectInTextView.origin.x,
                                         y: rectInTextView.origin.y - previewView.frame.size.height * 2)
    } else {
      previewView.removeFromSuperview()
    }
  }
}

