//
//  ToolbarDelegate.swift
//  ChatGPTForXcode
//
//  Created by 安部翔太 on 2023/03/24.
//

import SwiftUI

final class ToolbarDelegate: NSObject {}

extension NSToolbarItem.Identifier {
    static let openAboutPanel = NSToolbarItem.Identifier("com.Avis.ChatGPTForXcode.openAboutPanel")
}

extension ToolbarDelegate: NSToolbarDelegate {
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        let identifiers: [NSToolbarItem.Identifier] = [
            .flexibleSpace,
            .openAboutPanel
        ]
        return identifiers
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarDefaultItemIdentifiers(toolbar)
    }
    
    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        var toolbarItem: NSToolbarItem?
        
        switch itemIdentifier {
        case .openAboutPanel:
            let item = NSToolbarItem(itemIdentifier: itemIdentifier)
            item.image = NSImage(symbolName: "info.circle", variableValue: 20)
            item.label = "Open AboutPanel"
            // item.action = #selector(RecipeDetailViewController.editRecipe(_:))
            item.target = nil
            // item.view = NSHostingView(rootView: {
            //     Button {
            //         NSApplication.shared.orderFrontStandardAboutPanel(
            //             options: [NSApplication.AboutPanelOptionKey(rawValue: "Copyright"): "© 2023 Avis Inc"]
            //         )
            //     } label: {
            //         Image(systemName: "info.circle")
            //     }
            //     .fontWeight(.bold)
            // }())
            toolbarItem = item
            
        default:
            toolbarItem = nil
        }
        
        return toolbarItem
    }
}
