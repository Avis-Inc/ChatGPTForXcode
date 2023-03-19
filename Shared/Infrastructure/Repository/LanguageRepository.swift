//
//  LanguageRepository.swift
//  ChatGPTForXcode
//
//  Created by TAISHIN MIYAMOTO on 2023/03/18
//
//

import Foundation

struct LanguageRepository {
    private let key = "language"

    private let userDefaults = UserDefaults(suiteName: "com.ChatGPTForXcode.UserDefaults")

    func getSelectedLanguage() -> Language {
        let selectedLanguage = userDefaults?.string(forKey: key) ?? "English"
        return Language(rawValue: selectedLanguage) ?? Language.english
    }

    func saveSelectedLanguage(language: Language) {
        userDefaults?.set(language.rawValue, forKey: key)
    }
}
