//
//  SourceEditorCommand.swift
//  ChatGPTForXcodeEditorExtension
//  
//  Created by TAISHIN MIYAMOTO on 2023/03/08
//  
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        completionHandler(nil)
    }
    
}
