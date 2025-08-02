#!/usr/bin/env swift

import ApplicationServices
import Cocoa

let args = CommandLine.arguments

// TODO: make percentages configurable
if args.count < 2 {
  print("Usage: \(args[0]) <action>")
  print("Actions:")
  print("  full-screen: set window to full screen")
  print("  split-west: set window to west split (80%)")
  print("  split-east: set window to east split (80%)")
  exit(1)
}

let action = args[1]

var (size, position) = getSizeAndPosition(action: action)
guard let window = getActiveWindow() else {
  print("no active window found")
  exit(1)
}
let positionValue = AXValueCreate(.cgPoint, &position)!
let sizeValue = AXValueCreate(.cgSize, &size)!

AXUIElementSetAttributeValue(window, kAXPositionAttribute as CFString, positionValue)
AXUIElementSetAttributeValue(window, kAXSizeAttribute as CFString, sizeValue)

func getSizeAndPosition(action: String) -> (CGSize, CGPoint) {
  let screenFrame = NSScreen.main?.frame ?? CGRect.zero
  var width = screenFrame.width
  let height = screenFrame.height

  var position: CGPoint?
  if action == "split-west" {
    width = screenFrame.width * 0.8
    position = CGPoint(x: 0, y: 0)
  } else if action == "split-east" {
    width = screenFrame.width * 0.8
    position = CGPoint(x: screenFrame.width - width, y: 0)
  } else if action == "full-screen" {
    position = CGPoint(x: 0, y: 0)
  }

  guard let position = position else {
    fatalError("unknown action: \(action)")
  }

  return (CGSize(width: width, height: height), position)
}

func getActiveWindow() -> AXUIElement? {
  guard let frontmostApp = NSWorkspace.shared.frontmostApplication else {
    return nil
  }
  let appElement = AXUIElementCreateApplication(frontmostApp.processIdentifier)
  var windowsValue: CFTypeRef?
  let result = AXUIElementCopyAttributeValue(appElement, kAXWindowsAttribute as CFString, &windowsValue)
  guard result == .success, let windows = windowsValue as? [AXUIElement], !windows.isEmpty else {
    return nil
  }
  return windows[0]
}
