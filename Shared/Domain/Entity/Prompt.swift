//
//  Prompt.swift
//  ChatGPTForXcode
//
//  Created by TAISHIN MIYAMOTO on 2023/03/19
//
//

import Foundation

public enum Prompt {
    static func review(_ code: String, language: Language) -> String {
        """
        # decree: 
        Please output the problems with the input code.
        However, it is absolutely essential that the following constraints must be met.

        # constraint: 
        - If anything is unclear, please do not list anything.
        - If there is no problem, just output one word: "LGTM".
        - If there are any problems, please specify the specific areas.
        - Please keep sentences as short as possible and write a maximum of three items in list form.
        - \(language.prompt)

        # input:
        ```
        \(code)
        ```

        # output:
        """
    }

    static func refactor(_ code: String, language: Language) -> String {
        """
        # decree: 
        Please output the code after refactoring the input code.
        However, it is absolutely essential that the following constraints must be met.

        # constraint: 
        - Output the code after re-factoring
        - \(language.prompt)

        # input:
        ```
        \(code)
        ```

        # output:
        """
    }
}
