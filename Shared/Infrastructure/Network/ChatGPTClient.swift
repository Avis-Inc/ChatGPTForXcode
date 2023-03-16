//
//  ChatGPTClient.swift
//  ChatGPTForXcodeEditorExtension
//
//  Created by 安部翔太 on 2023/03/09.
//

import Combine
import OpenAISwift

struct ChatGPTClient {
    // MARK: Swift Concurrency
    static func send(
        authToken: String,
        chatMessages: [ChatMessage]
    ) async throws -> OpenAI<MessageResult> {
        let openAI = OpenAISwift(authToken: authToken)
        return try await openAI.sendChat(
            with: chatMessages,
            model: .chat(.chatgpt),
            maxTokens: 4096
        )
    }

    // MARK: Combine
    static func send(
        authToken: String,
        chatMessages: [ChatMessage]
    ) -> AnyPublisher<OpenAI<MessageResult>, OpenAIError> {
        Future { promise in
            let openAI = OpenAISwift(authToken: authToken)
            openAI.sendChat(
                with: chatMessages,
                model: .chat(.chatgpt),
                maxTokens: 4096
            ) { result in
                switch result {
                case let .success(messageResult):
                    promise(.success(messageResult))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    // MARK: Closure
    static func send(
        authToken: String,
        chatMessages: [ChatMessage],
        completionHandler: @escaping (Result<OpenAI<MessageResult>, OpenAIError>) -> Void
    ) {
        let openAI = OpenAISwift(authToken: authToken)
        openAI.sendChat(
            with: chatMessages,
            model: .chat(.chatgpt),
            maxTokens: 4096,
            completionHandler: completionHandler
        )
    }
}
