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
    var body: some Scene {
        WindowGroup {
            APIKeyInputView()
        }
        .windowResizability(.contentSize)
    }
}
