//
//  ContentView.swift
//  client
//
//  Created by 金澤帆高 on 2024/01/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
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
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
