//
//  SourceEditorCommand.swift
//  ChatGPTForXcodeEditorExtension
//
//  Created by TAISHIN MIYAMOTO on 2023/03/08
//
//

import Combine
import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    func perform(
        with invocation: XCSourceEditorCommandInvocation,
        completionHandler: @escaping (Error?) -> Void
    ) {
        let buffer = invocation.buffer
        guard let selections = buffer.selections as? [XCSourceTextRange],
              let selection = selections.first
        else {
            completionHandler(nil)
            return
        }

        var code = ""

        var indentCount = 0

        for lineIndex in selection.start.line ... selection.end.line {
            guard let line = buffer.lines[lineIndex] as? String else { continue }

            if code.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                indentCount = line.prefix(while: { $0 == " " }).count
            }

            if lineIndex == selection.start.line {
                code.append(contentsOf: line.dropFirst(selection.start.column))
            } else if lineIndex == selection.end.line {
                code.append(contentsOf: line.prefix(selection.end.column))
            } else {
                code.append(contentsOf: line)
            }
        }

        let authToken = ""

        let content = ""

        /// 以下のSwiftで書かれたコードの問題点をリスト形式で簡潔に出力してください。(最大3項目)
        /// 問題点がない場合は「LGTM」を出力してください。
        /// ```
        /// \(code)
        /// ```

        ChatGPTClient.send(
            authToken: authToken,
            chatMessages: [.init(role: .user, content: content)]
        ) { result in
            switch result {
            case let .success(messageResult):
                let indentSpace = String(repeating: " ", count: indentCount)
                let markerComment = "\(indentSpace)// MARK: Code Review"
                var reviewComment = messageResult.choices.first?.message.content ?? ""
                reviewComment = reviewComment
                    .split(separator: "\n")
                    .map { "\(indentSpace)/// \($0)" }
                    .joined(separator: "\n")
                let comments = [markerComment, reviewComment]
                let result = comments.joined(separator: "\n")
                buffer.lines.insert(result, at: selection.start.line)
                completionHandler(nil)
            case let .failure(error):
                print("✅:", error.localizedDescription)
                completionHandler(error)
            }
        }
    }
}
