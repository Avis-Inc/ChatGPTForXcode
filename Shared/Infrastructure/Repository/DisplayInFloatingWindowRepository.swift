//
//  DisplayInFloatingWindowRepository.swift
//  ChatGPTForXcode
//
//  Created by 安部翔太 on 2023/03/26.
//

import Foundation

public struct DisplayInFloatingWindowRepository {
    private let key = "displayInFloatingWindow"

    private let userDefaults = UserDefaults(suiteName: "com.ChatGPTForXcode.UserDefaults")

    func get() -> Bool {
        let bool = userDefaults?.bool(forKey: key)
        return bool ?? false
    }

    func save(_ bool: Bool) {
        userDefaults?.set(bool, forKey: key)
    }
}
