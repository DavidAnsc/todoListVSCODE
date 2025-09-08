//
//  ContentView.swift
//  normalViewModel.todoListVSCODE
//
//  Created by David An on 2025-08-21.
//

import SwiftUI

struct listView: View {

    @EnvironmentObject private var normalViewModel: listViewModel

    // @State var todoList: [todoModel] = [todoModel(title: "Sample Task 1", isStarred: false, isPinned: false),
    //                                     todoModel(title: "Sample Task 2", isStarred: true, isPinned: false),
    //                                     todoModel(title: "Sample Task 3", isStarred: false, isPinned: true)]
    // @State var tempList = ["Item1", "item2", "item3"]
    @State private var showSheet = false
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
				List {
                    if normalViewModel.todoList.filter({ $0.isPinned }).isEmpty && !normalViewModel.todoList.filter({ !$0.isPinned }).isEmpty {
                        normalList()
                    } else if normalViewModel.todoList.filter({ !$0.isPinned }).isEmpty && !normalViewModel.todoList.filter({ $0.isPinned }).isEmpty {
                        pinnedList()
                    } else if !normalViewModel.todoList.filter({ $0.isPinned }).isEmpty && !normalViewModel.todoList.filter({ !$0.isPinned }).isEmpty {
                        pinnedList()
                        normalList()
                    } else {
                        Text("No Tasks")
                            .foregroundStyle(Color.gray.opacity(0.7))
                            .italic()
                    }
				}
                .sheet(isPresented: $showSheet) {
                    creationView(showSheet: $showSheet)
                        // .environmentObject(normalViewModel)
                    .padding(.top, 15)
                        .presentationDetents([.height(120)])
                }
                
                
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            showSheet = true
                        } label: {
                            Image(systemName: "plus")
                                .bold()
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 40, height: 40)
                                )
                        }
                    }
                }
                .onAppear { normalViewModel.getData() }
                .navigationTitle("Todo List")



        
                NavigationLink(destination: completedView()) {
                    Label("Completed Ones", systemImage: "rectangle.stack")
                    .foregroundStyle(Color.primary)
                        .opacity(0.5)
                        .fontDesign(.rounded)
                        .padding(.bottom, 8)
                }
            }
        }
    }

    // func deleteItem(at offsets: IndexSet) {
    //     normalViewModel.todoList.remove(atOffsets: offsets)
    // }
    // func moveItem(from source: IndexSet, to destination: Int) {
    //     normalViewModel.todoList.move(fromOffsets: source, toOffset: destination)
    // }
}
