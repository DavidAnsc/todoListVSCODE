//
//  todoListVSCODEApp.swift
//  todoListVSCODE
//
//  Created by David An on 2025-08-21.
//

import SwiftUI

@main
struct todoListVSCODEApp: App {
    @StateObject private var normalViewModel = listViewModel(todoList: [])
    var body: some Scene {
        WindowGroup {
            listView()
                .environmentObject(normalViewModel)
        }
    }
}
