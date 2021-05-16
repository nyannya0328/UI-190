//
//  UI_190App.swift
//  UI-190
//
//  Created by にゃんにゃん丸 on 2021/05/16.
//

import SwiftUI

@main
struct UI_190App: App {
    var body: some Scene {
        
        #if os(iOS)
        WindowGroup {
            ContentView()
        }
        
        #else
        
        WindowGroup {
            ContentView()
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        
        #endif
        
        
    }
}
