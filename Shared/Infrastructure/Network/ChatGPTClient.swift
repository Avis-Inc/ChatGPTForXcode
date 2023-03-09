//
//  ChatGPTClient.swift
//  ChatGPTForXcodeEditorExtension
//
//  Created by 安部翔太 on 2023/03/09.
//

import OpenAISwift

struct ChatGPTClient {
    static func send(
        authToken: String,
        chatMessages: [ChatMessage]
    ) async throws -> String {
        let openAI = OpenAISwift(authToken: authToken)
        let result = try await openAI.sendChat(
            with: chatMessages,
            model: .chat(.chatgpt),
            maxTokens: 4096
        )
        
        return result.choices.first?.message.content ?? ""
    }
}
