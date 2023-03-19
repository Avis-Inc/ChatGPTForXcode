//
//  ChatGPTClient.swift
//  ChatGPTForXcodeEditorExtension
//
//  Created by 安部翔太 on 2023/03/09.
//

import Combine
import OpenAISwift

public struct ChatGPTClient {
    static func send(
        authToken: String,
        chatMessages: [ChatMessage]
    ) async throws -> OpenAI<MessageResult> {
        let openAI = OpenAISwift(authToken: authToken)
        return try await openAI.sendChat(
            with: chatMessages,
            model: .chat(.chatgpt),
            maxTokens: 300
        )
    }
}
