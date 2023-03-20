//
//  ReviewCommand.swift
//  ChatGPTForXcodeEditorExtension
//
//  Created by TAISHIN MIYAMOTO on 2023/03/08
//
//

import Foundation

final class ReviewCommand: BaseCommand {
    override var commandType: Command {
        .review
    }

    override func prompt(_ code: String, language: Language) -> String {
        Prompt.review(code, language: language)
    }
}
