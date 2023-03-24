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
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        // WindowGroup {
        //     ConfigurationView()
        // }
        // .windowResizability(.contentSize)
        
        MenuBarExtra {
            Button {
                print("button tapped!")
            } label: {
                Text("Button")
            }
        } label: {
            Image(systemName: "bubble.left.fill")
        }

    }
}

// chat-gpt-for-xcode://
