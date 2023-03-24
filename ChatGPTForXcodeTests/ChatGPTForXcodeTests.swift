//
//  ChatGPTForXcodeTests.swift
//  ChatGPTForXcodeTests
//  
//  Created by TAISHIN MIYAMOTO on 2023/03/24
//  
//

import XCTest

final class ChatGPTForXcodeTests: XCTestCase {

    var apiKeyRepository: APIKeyRepository!

    var languageRepository: LanguageRepository!

    override func setUpWithError() throws {
        apiKeyRepository = APIKeyRepository()

        languageRepository = LanguageRepository()
    }

    func testSaveAndGetAPIKey() {
        apiKeyRepository.saveAPIKey(apiKey: "12345")
        let apiKey = apiKeyRepository.getAPIKey()
        XCTAssertEqual(apiKey, "12345")
    }

    func testSaveAndGetSelectedLanguage() {
        languageRepository.saveSelectedLanguage(language: .japanese)
        let selectedLanguage = languageRepository.getSelectedLanguage()
        XCTAssertEqual(selectedLanguage, .japanese)
    }

    override func tearDownWithError() throws {
        let userDefaults = UserDefaults(suiteName: "com.ChatGPTForXcode.UserDefaults")!

        userDefaults.removeObject(forKey: "apiKey")
        apiKeyRepository = nil

        userDefaults.removeObject(forKey: "language")
        languageRepository = nil
    }
}
