//
//  todoListVSCODEApp.swift
//  todoListVSCODE
//
//  Created by David An on 2025-08-21.
//

import SwiftUI

@main
struct todoListVSCODEApp: App {
    @StateObject private var normalViewModel = ListViewModel(todoList: [])
    var body: some Scene {
        WindowGroup {
//            feedView()
                
             RecentView()
                 .environmentObject(normalViewModel)
        }
    }
}
