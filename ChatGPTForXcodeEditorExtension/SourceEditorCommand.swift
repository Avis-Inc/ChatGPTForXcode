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
        Task {
            let buffer = invocation.buffer
            guard let selections = buffer.selections as? [XCSourceTextRange],
                  let selection = selections.first
            else {
                completionHandler(nil)
                return
            }

            let lines = (selection.start.line ... selection.end.line)
                .compactMap { buffer.lines[$0] as? String }

            let code = lines.enumerated()
                .map { lineIndex, line -> String in
                    if lineIndex == selection.start.line {
                        return String(line.dropFirst(selection.start.column))
                    } else if lineIndex == selection.end.line {
                        return String(line.prefix(selection.end.column))
                    } else {
                        return line
                    }
                }
                .joined()

            let indentCount = lines
                .first { _ in
                    code.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                }
                .map { $0.prefix(while: { $0 == " " }).count } ?? 0

            let apiKeyRepository = APIKeyRepository()

            let languageRepository = LanguageRepository()

            let authToken = apiKeyRepository.getApiKey()

            let language = languageRepository.getSelectedLanguage()

            let content = """
            You are the Tech Lead Engineer for iOS.
            The output should meet the following constraints
            - Keep sentences short.
            - Limit the output to a maximum of three items.
            - Format the output as a list.
            - Don't mention if you're unsure of any issues.
            - Output only "LGTM" if there are no issues.
            - Indicate the specific area if there is an issue.

            ```
            \(code)
            ```

            \(language.prompt)
            """

            do {
                let messageResult = try await ChatGPTClient.send(
                    authToken: authToken,
                    chatMessages: [.init(role: .user, content: content)]
                )
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
            } catch {
                completionHandler(error)
            }
        }
    }
}
