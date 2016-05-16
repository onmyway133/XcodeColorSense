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

  // MARK: - Implementation

  func initialize() -> Bool {
    guard let mainMenu = NSApp.mainMenu else { return false }
    guard let item = mainMenu.itemWithTitle("Edit") else { return false }
    guard let submenu = item.submenu else { return false }

    let actionMenuItem = NSMenuItem(title:"Do Action", action:#selector(self.doMenuAction), keyEquivalent:"")
    actionMenuItem.target = self

    submenu.addItem(NSMenuItem.separatorItem())
    submenu.addItem(actionMenuItem)

    return true
  }

  func doMenuAction() {
    let error = NSError(domain: "Hello World!", code:42, userInfo:nil)
    NSAlert(error: error).runModal()
  }


}

