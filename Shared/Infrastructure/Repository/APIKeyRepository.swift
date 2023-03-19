//
//  APIKeyRepository.swift
//  ChatGPTForXcode
//
//  Created by 安部翔太 on 2023/03/17.
//

import Foundation

struct APIKeyRepository {
    private let key = "apiKey"

    private let userDefaults = UserDefaults(suiteName: "com.ChatGPTForXcode.UserDefaults")

    func getAPIKey() -> String {
        let apiKey = userDefaults?.string(forKey: key)
        return apiKey ?? ""
    }

    func saveAPIKey(apiKey: String) {
        userDefaults?.set(apiKey, forKey: key)
    }
}
