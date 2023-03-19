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
    }

    static func refactor(_ code: String, language: Language) -> String {
        """
        """
    }
}
