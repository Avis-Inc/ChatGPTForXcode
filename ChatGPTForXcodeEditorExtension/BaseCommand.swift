//
//  BaseCommand.swift
//  ChatGPTForXcodeEditorExtension
//
//  Created by TAISHIN MIYAMOTO on 2023/03/20
//
//

import Foundation
import XcodeKit
import AppKit

class BaseCommand: NSObject, XCSourceEditorCommand {
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
                .filter { $0 < buffer.lines.count }
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
                .first { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
                .map { $0.prefix(while: { $0 == " " }).count } ?? 0

            let apiKeyRepository = APIKeyRepository()

            let languageRepository = LanguageRepository()

            let authToken = apiKeyRepository.getAPIKey()

            let language = languageRepository.getSelectedLanguage()

            let content = prompt(code, language: language)

            do {
                let messageResult = try await ChatGPTClient.send(
                    authToken: authToken,
                    chatMessages: [
                        .init(role: .system, content: "The assistant should act as the Tech Lead Engineer for iOS."),
                        .init(role: .user, content: content)
                    ]
                )
                let indentSpace = String(repeating: " ", count: indentCount)
                let markerComment = "\(indentSpace)// MARK: \(commandType.rawValue)"
                var reviewComment = messageResult.choices.first?.message.content ?? ""
                reviewComment = reviewComment
                    .split(separator: "\n")
                    .map { "\(indentSpace)/// \($0)" }
                    .joined(separator: "\n")
                let comments = [markerComment, reviewComment]
                let result = comments.joined(separator: "\n")
                buffer.lines.insert(result, at: selection.start.line)
                if let url = URL(string: "chat-gpt-for-xcode://") {
                     NSWorkspace.shared.open(url)
                }
                completionHandler(nil)
            } catch {
                completionHandler(error)
            }
        }
    }

    var commandType: Command {
        fatalError("`commandType` must be implemented in subclasses")
    }

    func prompt(_ code: String, language: Language) -> String {
        fatalError("`prompt` must be implemented in subclasses")
    }
}
