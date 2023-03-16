//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Akari on 16.03.23.
//

import SwiftUI


@main
struct MenubarAppApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject,ObservableObject,NSApplicationDelegate{
    @Published var statusItem: NSStatusItem?
    @Published var popover = NSPopover()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setUpMacMenu()
    }
    
    func setUpMacMenu(){
        popover.animates = true
        popover.behavior = .transient
        
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = NSHostingView(rootView: Home())
        
        popover.contentViewController?.view.window?.makeKey()
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let menuButton = statusItem?.button{
            menuButton.image = .init(systemSymbolName: "hammer", accessibilityDescription: nil)
            menuButton.action = #selector(menuButtonAction(sender:))
        }
    }
    
    @objc func menuButtonAction(sender: AnyObject){
        if popover.isShown{
            popover.performClose(sender)
        }
        else{
            if let menuButton = statusItem?.button{
                popover.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .minY)
            }
        }
    }
}
