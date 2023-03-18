//
//  APIKeyInputView.swift
//  ChatGPTForXcode
//
//  Created by 安部翔太 on 2023/03/17.
//

import SwiftUI

struct APIKeyInputView: View {
    private let apiKeyRepository = APIKeyRepository()
    
    @State private var apiKey = ""
    
    var body: some View {
        VStack(spacing: 10) {
            headline("1. Get your API Key from OpenAI.")
            
            link()
            
            headline("2. Enter your API Key.")
            
            TextField("sk-...", text: $apiKey)
        }
        .frame(width: 360)
        .frame(width: 440, height: 400)
        .onAppear {
            apiKey = apiKeyRepository.getApiKey()
        }
        .onChange(of: apiKey, perform: apiKeyRepository.saveApiKey(apiKey:))
    }
}

extension APIKeyInputView {
    private func headline(_ text: String) -> some View {
        Text(text)
            .font(.title2)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func link() -> some View {
        let urlString = "https://platform.openai.com/account/api-keys"
        if let url = URL(string: urlString) {
            Link(urlString, destination: url)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct APIKeyInputView_Previews: PreviewProvider {
    static var previews: some View {
        APIKeyInputView()
    }
}
