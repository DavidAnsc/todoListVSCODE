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
            List {

                ForEach(Array(normalViewModel.todoList.enumerated()), id: \.offset) { index, item in
                    listRowView(todo: item)
                    .onTapGesture {
                        normalViewModel.todoList[index].isDone.toggle()
                    }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                normalViewModel.todoList.remove(at: index)
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(Color.red)


                            Button {
                                normalViewModel.todoList[index].isStarred.toggle()
                            } label: {
                                Image(systemName: item.isStarred ?  "star.slash" : "star.fill")
                                .foregroundStyle(item.isStarred ? .white : .gray.opacity(0.4))
                            }
                            .tint(item.isStarred ? Color.gray : Color(#colorLiteral(red: 0.8666666666666667, green: 0.7843137254901961, blue: 0.054901960784313725, alpha: 1.0)))
                        }
                // .onDelete(perform: deleteItem)
                }
                .onMove(perform: moveItem)
            }
            .sheet(isPresented: $showSheet) {
                creationView(todoList: $normalViewModel.todoList)
                .padding(.top, 15)
                    .presentationDetents([.height(120)])
            }
            
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    EditButton()
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading, 8)
                        .background(
                            Capsule()
                                .fill(Color.orange.opacity(0.8))
                                .frame(width: 50, height: 30)
                        )
                }


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
            .navigationTitle("Todo List")
        }
    }

    func deleteItem(at offsets: IndexSet) {
        normalViewModel.todoList.remove(atOffsets: offsets)
    }
    func moveItem(from source: IndexSet, to destination: Int) {
        normalViewModel.todoList.move(fromOffsets: source, toOffset: destination)
    }
}
