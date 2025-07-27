#!/usr/bin/env swift

import Cocoa
import ApplicationServices

func findWindow(appName: String) -> AXUIElement? {
    let apps = NSWorkspace.shared.runningApplications
    guard let app = apps.first(where: { $0.localizedName == appName }) else {
        print("App '\(appName)' not found")
        return nil
    }
    
    let appElement = AXUIElementCreateApplication(app.processIdentifier)
    var windowsValue: CFTypeRef?
    
    let result = AXUIElementCopyAttributeValue(appElement, kAXWindowsAttribute as CFString, &windowsValue)
    guard result == .success, let windows = windowsValue as? [AXUIElement], !windows.isEmpty else {
        print("No windows found for \(appName)")
        return nil
    }
    
    return windows[0] // Return front window
}

func getWindowBounds(_ window: AXUIElement) -> (CGPoint, CGSize)? {
    var positionValue: CFTypeRef?
    var sizeValue: CFTypeRef?
    
    guard AXUIElementCopyAttributeValue(window, kAXPositionAttribute as CFString, &positionValue) == .success,
          AXUIElementCopyAttributeValue(window, kAXSizeAttribute as CFString, &sizeValue) == .success else {
        return nil
    }
    
    var position = CGPoint.zero
    var size = CGSize.zero
    
    AXValueGetValue(positionValue as! AXValue, .cgPoint, &position)
    AXValueGetValue(sizeValue as! AXValue, .cgSize, &size)
    
    return (position, size)
}

func resizeWindow(_ window: AXUIElement, newSize: inout CGSize) {
    let sizeValue = AXValueCreate(.cgSize, &newSize)!
    AXUIElementSetAttributeValue(window, kAXSizeAttribute as CFString, sizeValue)
}

func moveWindow(_ window: AXUIElement, newPosition: inout CGPoint) {
    let positionValue = AXValueCreate(.cgPoint, &newPosition)!
    AXUIElementSetAttributeValue(window, kAXPositionAttribute as CFString, positionValue)
}

// Main execution
let args = CommandLine.arguments

if args.count < 3 {
    print("Usage: \(args[0]) <app-name> <width-increase>")
    print("Example: \(args[0]) 'Google Chrome' 200")
    exit(1)
}

let appName = args[1]
let widthIncrease = Double(args[2]) ?? 0

guard let window = findWindow(appName: appName) else {
    exit(1)
}

guard let (position, size) = getWindowBounds(window) else {
    print("Failed to get window bounds")
    exit(1)
}

print("Current: \(size.width)x\(size.height) at (\(position.x), \(position.y))")

var newSize = CGSize(width: size.width + widthIncrease, height: size.height)
resizeWindow(window, newSize: &newSize)

print("Resized to: \(newSize.width)x\(newSize.height)")
