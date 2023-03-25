//
//  ChatView.swift
//  ChatGPTForXcode
//
//  Created by 安部翔太 on 2023/03/25.
//

import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let text: String
}

final class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
}

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    var body: some View {
        List(viewModel.messages) { message in
            VStack(spacing: 4) {
                Text(message.text)
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
            }
        }
        .frame(minWidth: 200, minHeight: 200)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: .init())
    }
}
