//
//  APIKeyRepository.swift
//  ChatGPTForXcode
//
//  Created by 安部翔太 on 2023/03/17.
//

import Foundation

public struct APIKeyRepository {
    private let key = "apiKey"

    private let userDefaults = UserDefaults.standard

    func getApiKey() -> String {
        let apiKey = userDefaults.string(forKey: key)
        return apiKey ?? ""
    }

    func saveApiKey(apiKey: String) {
        userDefaults.set(apiKey, forKey: key)
    }
}
