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
    ) async throws -> String {
        let openAI = OpenAISwift(authToken: authToken)
        let result = try await openAI.sendChat(
            with: chatMessages,
            model: .chat(.chatgpt),
            maxTokens: 4096
        )

        return result.choices.first?.message.content ?? ""
    }

    // MARK: Combine
    static func send(
        authToken: String,
        chatMessages: [ChatMessage]
    ) -> AnyPublisher<String, OpenAIError> {
        Future { promise in
            let openAI = OpenAISwift(authToken: authToken)
            openAI.sendChat(
                with: chatMessages,
                model: .chat(.chatgpt),
                maxTokens: 4096
            ) { result in
                switch result {
                case let .success(message):
                    promise(.success(message.choices.first?.message.content ?? ""))
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
