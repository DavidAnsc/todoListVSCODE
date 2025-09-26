//
//  ContentView.swift
//  normalViewModel.todoListVSCODE
//
//  Created by David An on 2025-08-21.
//

import SwiftUI

struct ListView: View {

    @EnvironmentObject private var normalViewModel: listViewModel

    // @State var todoList: [todoModel] = [todoModel(title: "Sample Task 1", isStarred: false, isPinned: false),
    //                                     todoModel(title: "Sample Task 2", isStarred: true, isPinned: false),
    //                                     todoModel(title: "Sample Task 3", isStarred: false, isPinned: true)]
    // @State var tempList = ["Item1", "item2", "item3"]
    @State private var showSheet = false
    @State private var showMenu = false
    var body: some View {
        NavigationStack {
            ZStack(alignment: .leading) {
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
                        .presentationDetents([.height(150)])
                }
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Capsule()
                            .frame(width: 50, height: 40)
                            .foregroundStyle(Color.clear)
                            .overlay(
                                Image(systemName: "list.bullet")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .bold()
                                    .foregroundColor(.black)
                                    .padding()
                                    .contentShape(Rectangle())
                            )
                            .onTapGesture {
                                withAnimation(.smooth(duration: 0.3)) {
                                    showMenu.toggle()
                                }
                            }
                        
                            
                    }


                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            showSheet = true
                        } label: {
                            Image(systemName: "plus")
                                .bold()
                                .foregroundColor(.blue)
                                .background(
                                    Circle()
                                        .fill(Color.clear)
                                        .frame(width: 40, height: 40)
                                )
                        }
                    }
                }
                .onAppear { normalViewModel.getData() }
                .navigationTitle("Get Stuff Done")
//                .navigationBarTitleDisplayMode(.inline)

                .scrollDisabled(showMenu ? true : false)
                // Rectangle()
                //     .ignoresSafeArea()
                //     .opacity(showMenu ? 0.25 : 0)
                //     .onTapGesture {
                //         withAnimation(.smooth(duration: 0.3)) {
                //             showMenu = false
                //         }
                //     }                
                
                    
                    

                menuView(showMenu: $showMenu)
                    .offset(x: 0, y: 0)
                    .ignoresSafeArea()



        
                // NavigationLink(destination: completedView()) {
                //     Label("Completed Ones", systemImage: "rectangle.stack")
                //     .foregroundStyle(Color.primary)
                //         .opacity(0.5)
                //         .fontDesign(.rounded)
                //         .padding(.bottom, 8)
                // }
            }
			.navigationBarBackButtonHidden(true)
        }
    }

    // func deleteItem(at offsets: IndexSet) {
    //     normalViewModel.todoList.remove(atOffsets: offsets)
    // }
    // func moveItem(from source: IndexSet, to destination: Int) {
    //     normalViewModel.todoList.move(fromOffsets: source, toOffset: destination)
    // }
}


struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

#Preview {
	@Previewable @StateObject var normalViewModel: listViewModel = listViewModel(todoList: [todoModel(title: "Hi", isStarred: false, isPinned: false)])
	ListView()
		.environmentObject(normalViewModel)
		
}
