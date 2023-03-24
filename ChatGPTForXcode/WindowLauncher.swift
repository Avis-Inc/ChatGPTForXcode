//
//  WindowLauncher.swift
//  ChatGPTForXcode
//
//  Created by 安部翔太 on 2023/03/24.
//

import SwiftUI

struct WindowLauncher {
    static func openChatPanel() {
        let view = Text("hello")
            .frame(minWidth: 200, minHeight: 200)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        let controller = NSHostingController(rootView: view)

        let panel = NSPanel(
            contentRect: .zero,
            styleMask: [
                .closable,
                .miniaturizable,
                .nonactivatingPanel,
                .titled,
                .resizable
            ],
            backing: .buffered,
            defer: false)
        panel.contentViewController = controller
        panel.level = .floating
        panel.collectionBehavior = [
            .canJoinAllSpaces,
            .fullScreenAuxiliary
        ]
        panel.isMovableByWindowBackground = true
        panel.center()
        panel.makeKeyAndOrderFront(nil)
    }
    
    static func openConfigurationView() {
        let view = ConfigurationView()
        let controller = NSHostingController(rootView: view)
        
        let window = NSWindow(
            contentRect: .zero,
            styleMask: [
                .closable,
                .miniaturizable,
                .titled,
                .resizable
            ],
            backing: .buffered,
            defer: false)
        window.contentViewController = controller
        window.toolbar = {
            let toolbar = NSToolbar(identifier: "main")
            let toolbarDelegate = ToolbarDelegate()
            toolbar.delegate = toolbarDelegate
            return toolbar
        }()
        window.toolbarStyle = .unified
        window.center()
        window.makeKeyAndOrderFront(nil)
    }
}
