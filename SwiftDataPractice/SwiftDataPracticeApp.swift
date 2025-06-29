//
//  SwiftDataPracticeApp.swift
//  SwiftDataPractice
//
//  Created by Onur Altintas on 29.06.2025.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
