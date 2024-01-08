//
//  ContentView.swift
//  client
//
//  Created by 金澤帆高 on 2024/01/08.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText = ""
    @State private var responseText = ""
    @State private var receivedMessage = ""
    private let webSocketTask = URLSession.shared.webSocketTask(with: URL(string: "ws://localhost:31577/websocket")!)
    
    
    
    var body: some View {
        VStack {
            
            Button("Send Request to Fastify") {
                sendRequest { result in
                    switch result {
                    case .success(let response):
                        print("Response: \(response)")
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            }
            
            TextField("Enter text here", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Send") {
                sendTextToServer(inputText) { newText in
                    responseText = newText
                }
            }
            .padding()
            
            Text(responseText)
                .padding()
            
            Text(receivedMessage)
            Button("ボタンを押す") {
                sendMessage()
                print(sendMessage())
            }
        }
        .padding()
    }
    
    private func startReceivingMessages() {
        webSocketTask.resume()
        receiveMessage()
    }
    
    private func receiveMessage() {
        webSocketTask.receive { result in
            switch result {
            case .failure(let error):
                print("メッセージの受信に失敗しました: \(error)")
            case .success(.string(let message)):
                DispatchQueue.main.async {
                    self.receivedMessage = message
                }
                receiveMessage() // 次のメッセージの受信を続ける
            default:
                break
            }
        }
    }

    
    private func sendMessage() {
        let message = URLSessionWebSocketTask.Message.string("相手がボタンを押しました")
        webSocketTask.send(message) { error in
            if let error = error {
                print("メッセージの送信に失敗しました: \(error)")
            }
        }
    }
    
}



#Preview {
    ContentView()
}
