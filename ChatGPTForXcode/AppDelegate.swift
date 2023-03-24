//
//  AppDelegate.swift
//  ChatGPTForXcode
//
//  Created by 安部翔太 on 2023/03/24.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    
    func application(_ application: NSApplication, open urls: [URL]) {
        print(urls)
        WindowLauncher.openChatPanel()
        WindowLauncher.openConfigurationView()
    }
}
