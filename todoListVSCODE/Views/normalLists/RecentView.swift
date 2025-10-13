//
//  ContentView.swift
//  normalViewModel.todoListVSCODE
//
//  Created by David An on 2025-08-21.
//

import SwiftUI

struct RecentView: View {

    @EnvironmentObject private var normalViewModel: listViewModel

	@Environment(\.colorScheme) var colorScheme
	
    @State private var showSheet = false
    @State private var showMenu = false
    var body: some View {
        NavigationStack {
            ZStack(alignment: .leading) {
				List {
                    ListView()
				}
                .sheet(isPresented: $showSheet) {
                    creationView(showSheet: $showSheet)
                        // .environmentObject(normalViewModel)
                    .padding(.top, 15)
                        .presentationDetents([.height(140)])
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
                                    .foregroundColor(.primary)
                                    .padding()
                                    .contentShape(Rectangle())
                            )
                            .onTapGesture {
                                showMenu.toggle()
                            }  
                    }
                    
                    if !showMenu {
                        


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
                }
                .onAppear { normalViewModel.getData() }
                .navigationTitle("Recent")
//                .navigationBarTitleDisplayMode(.inline)

                .scrollDisabled(showMenu ? true : false)


				if normalViewModel.todoList.filter({ $0.isPinned && !$0.isHidden }).isEmpty && normalViewModel.todoList.filter({ !$0.isPinned && !$0.isHidden }).isEmpty && colorScheme == .dark {
                    HStack {
                        Spacer()
                        Image("noTask img")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250) 
                        Spacer()
                    }
				} else if normalViewModel.todoList.filter({ $0.isPinned && !$0.isHidden }).isEmpty && normalViewModel.todoList.filter({ !$0.isPinned && !$0.isHidden }).isEmpty && colorScheme == .light {
					HStack {
						Spacer()
						Image("noTask imgDark")
							.resizable()
							.scaledToFit()
							.frame(width: 250)
						Spacer()
					}
				}
                    

                menuView(showMenu: $showMenu)
                    .offset(x: 0, y: 0)
                    .ignoresSafeArea()
                    .animation(.smooth(duration: 0.5), value: showMenu)
                    .transition(.scale)



        
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
	RecentView()
		.environmentObject(normalViewModel)
		
}
