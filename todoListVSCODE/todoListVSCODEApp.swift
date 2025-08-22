//
//  todoListVSCODEApp.swift
//  todoListVSCODE
//
//  Created by David An on 2025-08-21.
//

import SwiftUI

@main
struct todoListVSCODEApp: App {
    @StateObject private var normalViewModel = listViewModel(todoList: [
        todoModel(title: "Sample Task 1", isDone: false, isStarred: false, isPinned: false),
        todoModel(title: "Sample Task 2", isDone: false, isStarred: true, isPinned: false),
        todoModel(title: "Sample Task 3", isDone: false, isStarred: false, isPinned: true)
    ])
    var body: some Scene {
        WindowGroup {
            listView()
                .environmentObject(normalViewModel)
        }
    }
}
