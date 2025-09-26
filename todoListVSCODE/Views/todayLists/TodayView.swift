//
//  TodayView.swift
//  todoListVSCODE
//
//  Created by David An on 2025-09-10.
//

import SwiftUI

struct TodayView: View {
	@EnvironmentObject private var normalViewModel: listViewModel
	
	// @State var todoList: [todoModel] = [todoModel(title: "Sample Task 1", isStarred: false, isPinned: false),
	//                                     todoModel(title: "Sample Task 2", isStarred: true, isPinned: false),
	//                                     todoModel(title: "Sample Task 3", isStarred: false, isPinned: true)]
	// @State var tempList = ["Item1", "item2", "item3"]
	@State private var showSheet = false
	@State private var showMenu = false
	
	@State private var normalCount = 0
	@State private var pinnedCount = 0
	var body: some View {
		NavigationStack {
			ZStack(alignment: .leading) {
				List {
					if normalCount != 0 && pinnedCount == 0 {
						normalList2(normalCount: $normalCount)
					} else if normalCount == 0 && pinnedCount != 0 {
						pinnedList2(pinnedCount: $pinnedCount)
					} else if normalCount != 0 && pinnedCount != 0 {
						pinnedList2(pinnedCount: $pinnedCount)
						normalList2(normalCount: $normalCount)
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
					ToolbarItemGroup(placement: .topBarLeading) {
						Capsule()
							.fill(Color.clear)
							.frame(width: 50, height: 40)
							.overlay(
								Image(systemName: "list.bullet")
									.resizable()
									.scaledToFit()
									.frame(width: 20, height: 20)
									.bold()
//									.foregroundColor(.white)
							)
							.onTapGesture {
								withAnimation(.smooth(duration: 0.3)) {
									showMenu.toggle()
								}
							}
							.opacity(showMenu ? 0 : 1)
						
						
					}
					
					
					
					ToolbarItem(placement: .principal) {
						HStack {
							Image(systemName: "calendar.circle.fill") // Your system image
								.foregroundColor(.red)
								.padding(.leading, -2)
							Text("Today") // Optional: Text alongside the image
								.padding(.leading, -4)
						}
						.font(.headline)
						.padding(4.5)
//						.contentShape(Rectangle())
						.background(
							RoundedRectangle(cornerRadius: 15)
								.fill(Color.gray.opacity(0.3))
						)
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
								.brightness(showMenu ? -0.25 : 0)
						}
					}
				}
				.onAppear { normalViewModel.getData() }
				.navigationTitle("Today")
				
				.navigationBarTitleDisplayMode(.inline)
				
				.scrollDisabled(showMenu ? true : false)
				// Rectangle()
				//     .ignoresSafeArea()
				//     .opacity(showMenu ? 0.25 : 0)
				//     .onTapGesture {
				//         withAnimation(.smooth(duration: 0.3)) {
				//             showMenu = false
				//         }
				//     }
				
				
				// VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
				//         .ignoresSafeArea()
				//         .mask(RoundedRectangle(cornerRadius: 32).frame(width: 150, height: 190).offset(x: -117, y: -307))
				//         .onTapGesture {
				//             withAnimation(.smooth(duration: 0.3)) {
				//                 showMenu = false
				//             }
				//         }
				//         .opacity(showMenu ? 1 : 0)
				
				
				
				
				
				
				
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
		}
		.navigationBarBackButtonHidden(true)
	}
}
	#Preview {
		@Previewable @StateObject var normalViewModel: listViewModel = listViewModel(todoList: [todoModel(title: "Item", isStarred: false, isPinned: false)])
		TodayView()
			.environmentObject(normalViewModel)
	}
