import SwiftUI
import Foundation

struct ListRowView: View {
	@State var goingHiding = false
	// MARK: compute formatted date dynamically so it updates whenever the `item` changes
	private var formattedDate: String {
		normalViewModel.getFormattedDate(in: item)
	}
	
	@EnvironmentObject var normalViewModel: ListViewModel
	@State var showEditSheet: Bool = false
	@State var itemHiding = false
	@State var showPicker = false
	@Binding var showEditingBar: Bool
	
	
	let item: TodoModel
	var body: some View {
		let isBeforeToday = normalViewModel.isBeforeToday(in: item)
		ZStack {
			Group {
				HStack {
					if item.isDone == false {
						HStack {
							Capsule()
								.stroke(lineWidth: 1)
								.foregroundStyle(Color.gray.opacity(0.7))
								.frame(width: 33, height: 25)
								.padding(2)
								.contentShape(Rectangle())
								.onTapGesture {
									goingHiding = true
									withAnimation(.smooth(duration: 0.3)) {
										normalViewModel.toggleCompletion(item: item)
										ListViewModel.getDoneHaptic()
									}
								}
								.padding(.trailing, 3)
							
							Text(item.title)
								.foregroundStyle(item.isDone ? Color.gray : Color.primary)
								.font(.system(size: 16))
								.kerning(0.25)
								.padding(.trailing, 3)
							
								.onTapGesture {
									showEditSheet.toggle()
									ListViewModel.getClickHaptic()
								}
							
							Image(systemName: "text.page")
								.font(.system(size: 12))
								.foregroundStyle(Color.gray.opacity(0.8))
								.opacity(item.notes.isEmpty ? 0 : 1)
								.padding(.horizontal, 0)
							
								.onTapGesture {
									showEditSheet.toggle()
								}
							
							Spacer()
							
							Image(systemName: "star.fill")
								.font(.system(size: 12))
								.foregroundStyle(item.isStarred ? Color.yellow : Color.clear)
								.padding(.horizontal, 7)
							
							//						Text(Calendar.current.isDate(item.dueDate, inSameDayAs: Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))!) ? "Tomorrow" : Calendar.current.isDate(item.dueDate, inSameDayAs: Calendar.current.date(byAdding: .day, value: 0, to: Calendar.current.startOfDay(for: Date()))!) ? "Today" : item.dueDate.formatted(date: .abbreviated, time: .omitted))
							
							
							Text(formattedDate)
								.font(.system(size: 13))
								.kerning(0.25)
								.padding(.horizontal, 3)
								.padding(.vertical, 1)
								.background(
									RoundedRectangle(cornerRadius: 5)
										.fill(
											isBeforeToday
											? Color.red.opacity(0.2)
											: Color.gray.opacity(0.15)
										)
								)
								.fontWeight(.regular)
								.onTapGesture {
									ListViewModel.getClickHaptic()
									showEditSheet = true
									DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
										showPicker = true
									}
								}
						}
						
						
					} else if item.isDone && item.isHidden == false {
						HStack {
							ZStack {
								Capsule()
									.stroke(lineWidth: 1)
									.foregroundStyle(Color.gray.opacity(0.7))
									.frame(width: 33, height: 25)
									.padding(2)
									.contentShape(Rectangle())
								//								.onTapGesture {
								//									withAnimation(.smooth(duration: 0.3)) {
								//										normalViewModel.toggleCompletion(item: item)
								//										ListViewModel.getDoneHaptic()
								//									}
								//								}
								Capsule()
									.foregroundStyle(Color("Inner Capsule"))
									.shadow(radius: 3)
									.frame(width: 25, height: 19)
									.padding(4)
								
									.onAppear {
										
										
										DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
											if goingHiding && item.isDone {
												DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
													if goingHiding && item.isDone {
														normalViewModel.toggleHidden(item: item)
													} else {
														goingHiding = false
													}
												}
											} else {
												goingHiding = false
											}
										}
										
									}
								
									.onTapGesture {
										goingHiding = false
										withAnimation(.smooth(duration: 0.3)) {
											normalViewModel.toggleCompletion(item: item)
											ListViewModel.getCancelHaptic()
										}
									}
								
							}
							.padding(.trailing, 3)
							
							Text(item.title)
								.foregroundStyle(item.isDone ? Color.gray : Color.primary)
								.font(.system(size: 16))
								.kerning(0.25)
								.padding(.trailing, 3)
							
								.onTapGesture {
									showEditSheet.toggle()
								}
							
							Image(systemName: "text.page")
								.font(.system(size: 12))
								.foregroundStyle(Color.gray.opacity(0.8))
								.opacity(item.notes.isEmpty ? 0 : 1)
								.padding(.horizontal, 0)
							
								.onTapGesture {
									showEditSheet.toggle()
								}
							
							Spacer()
							
							Image(systemName: "star.fill")
								.font(.system(size: 12))
								.foregroundStyle(item.isStarred ? Color.yellow : Color.clear)
								.padding(.horizontal, 7)
							
							Text(formattedDate)
								.font(.system(size: 13))
								.kerning(0.25)
								.padding(.horizontal, 3)
								.padding(.vertical, 1)
								.background(
									
									
									RoundedRectangle(cornerRadius: 5)
										.fill(
											isBeforeToday
											? Color.red.opacity(0.2)
											: Color.gray.opacity(0.15)
										)
								)
								.fontWeight(.regular)
								.onTapGesture {
									withAnimation(.smooth(duration: 0.3)) {
										showEditSheet.toggle()
									}
								}
						}
						
					}
					//				} else if item.isDone && hideItem == true {
					//					EmptyView()
					//				}
					
					
					
					
					
					
				}
				
				//			.onAppear {
				//				formattedDate = normalViewModel.getFormattedDate(in: item)
				//			}
				.swipeActions(edge: .leading, allowsFullSwipe: false) {
					Button {
						normalViewModel.togglePin(item: item)
					} label: {
						Image(systemName: item.isPinned ? "pin.slash.fill" : "pin.fill")
							.foregroundStyle(item.isPinned ? Color.gray.opacity(0.4) : Color.blue)
					}
					.tint(item.isPinned ? Color(#colorLiteral(red: 0.5647058823529412, green: 0.5647058823529412, blue: 0.5647058823529412, alpha: 1.0)): Color.blue)
				}
				.swipeActions(edge: .trailing, allowsFullSwipe: true) {
					Button(role: .destructive) {
						showEditSheet = false // Dismiss sheet before removing
						itemHiding = true
						normalViewModel.removeItem(item: item)
					} label: {
						Image(systemName: "trash")
					}
					.tint(Color.red)
					
					
					Button {
						normalViewModel.toggleStar(item: item)
					} label: {
						Image(systemName: item.isStarred ?  "star.slash" : "star.fill")
							.foregroundStyle(item.isStarred ? .white : .gray.opacity(0.4))
					}
					.tint(item.isStarred ? Color.gray : Color(#colorLiteral(red: 0.8666666666666667, green: 0.7843137254901961, blue: 0.054901960784313725, alpha: 1.0)))
				}
				.sheet(isPresented: $showEditSheet) {
					EditView(showEditSheet: $showEditSheet, object: $normalViewModel.todoList.first(where: { $0.id == item.id })!, showPicker: $showPicker, showNoticeBar: $showEditingBar)
						.padding(.top, 15)
						.presentationDetents([.height(140)])
					
				}
				
			}
		}
	}
}

// #Preview {
// 	@Previewable @State var todo: todoModel = todoModel(todo.title: "Item", todo.isStarred: false, todo.isPinned: false)
// 	listRowView(todo: $todo)

// }

