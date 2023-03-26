//
//  ChatGPTForXcodeApp.swift
//  ChatGPTForXcode
//
//  Created by TAISHIN MIYAMOTO on 2023/03/08
//
//

import SwiftUI

@main
struct ChatGPTForXcodeApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate : AppDelegate
    var body: some Scene {
        MenuBarExtra {
            Button {
                NSApplication.shared.terminate(self)
            } label: {
                Text("Quit")
            }
        } label: {
            Image(systemName: "bubble.left.fill")
        }

    }
}

// chat-gpt-for-xcode://

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if NSApplication.shared.windows.filter({$0.identifier == .init("configurationWindow")}).first != nil {
            return
        }
        let view = ConfigurationView()
        let controller = NSHostingController(rootView: view)
        
        let window = NSPanel(
            contentRect: .zero,
            styleMask: [
                .closable,
                .miniaturizable,
                .titled,
            ],
            backing: .buffered,
            defer: false)
        window.identifier = .init("configurationWindow")
        window.contentViewController = controller
        window.toolbarStyle = .unified
        window.toolbar = .init()
        window.center()
        window.makeKeyAndOrderFront(nil)
    }
    
    func application(_ application: NSApplication, open urls: [URL]) {
        print(urls)
        if let url = urls.first {
            openChatPanel(url: url)
        }
    }
    
    let chatViewModel = ChatViewModel()
    
    private func openChatPanel(url: URL) {
        guard let query = url.query,
              let text = query.removingPercentEncoding
        else { return }
        
        chatViewModel.messages.append(.init(text: text))
        
        if NSApplication.shared.windows.filter({$0.identifier == .init("chatPanel")}).first != nil {
            return
        }
                
        let view = ChatView(viewModel: self.chatViewModel)
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
        panel.identifier = .init("chatPanel")
        panel.contentViewController = controller
        panel.level = .floating
        panel.collectionBehavior = [
            .canJoinAllSpaces,
            .fullScreenAuxiliary
        ]
        panel.center()
        panel.makeKeyAndOrderFront(nil)
    }
}
