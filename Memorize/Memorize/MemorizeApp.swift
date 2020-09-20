//
//  MemorizeApp.swift
//  Memorize
//
//  Created by JiaShu Huang on 2020/9/19.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGame()
            ContentView(viewModel: game)
        }
    }
}
