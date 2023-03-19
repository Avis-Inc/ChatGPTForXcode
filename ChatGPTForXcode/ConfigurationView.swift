//
//  PreferencesView.swift
//  ChatGPTForXcode
//
//  Created by 安部翔太 on 2023/03/17.
//

import SwiftUI

struct ConfigurationView: View {
    private let apiKeyRepository = APIKeyRepository()

    private let languageRepository = LanguageRepository()

    @State private var apiKey = ""

    @State private var selectedLanguage = Language.english

    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                headline("1. Obtain your API Key from OpenAI.")

                link()

                headline("2. Input your API Key.")

                TextField("sk-...", text: $apiKey)

                headline("3. Specify the output language setting.")

                languagePicker()
            }
            .padding(.init(top: 25, leading: 25, bottom: 25, trailing: 28))
            .frame(width: 400, height: 230, alignment: .center)
            .onAppear {
                apiKey = apiKeyRepository.getAPIKey()
                selectedLanguage = languageRepository.getSelectedLanguage()
            }
            .onChange(of: apiKey, perform: apiKeyRepository.saveAPIKey(apiKey:))
            .onChange(of: selectedLanguage, perform: languageRepository.saveSelectedLanguage(language:))
            .navigationTitle("ChatGPT for Xcode")
            .toolbar {
                toolbarButton()
            }
        }
    }
}

extension ConfigurationView {
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

    private func languagePicker() -> some View {
        Picker("", selection: $selectedLanguage) {
            ForEach(Language.allCases, id: \.self) { language in
                Text(language.name)
            }
        }
        .labelsHidden()
    }

    private func toolbarButton() -> some View {
        Button {
            orderFrontStandardAboutPanel()
        } label: {
            Image(systemName: "info.circle")
        }
        .fontWeight(.bold)
    }

    private func orderFrontStandardAboutPanel() {
        NSApplication.shared.orderFrontStandardAboutPanel(
            options: [NSApplication.AboutPanelOptionKey(rawValue: "Copyright"): "© 2023 Avis Inc"]
        )
    }
}

struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView()
    }
}
