//
//  RefactorCommand.swift
//  ChatGPTForXcodeEditorExtension
//
//  Created by TAISHIN MIYAMOTO on 2023/03/20
//
//

import Foundation

final class RefactorCommand: BaseCommand {
    override var commandType: Command {
        .refactor
    }

    override func prompt(_ code: String, language: Language) -> String {
        Prompt.refactor(code, language: language)
    }
}
