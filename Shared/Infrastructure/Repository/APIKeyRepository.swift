//
//  APIKeyRepository.swift
//  ChatGPTForXcode
//
//  Created by 安部翔太 on 2023/03/17.
//

import Foundation

struct APIKeyRepository {
    private let apiKeyKey = "apiKey"
    private let userDefaults = UserDefaults.standard
    func getApiKey() -> String {
        let apiKey = userDefaults.string(forKey: apiKeyKey)
        return apiKey ?? ""
    }
    func saveApiKey(apiKey: String) {
        userDefaults.set(apiKey, forKey: apiKeyKey)
    }
}
