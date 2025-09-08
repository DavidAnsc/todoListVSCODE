import SwiftUI

struct listRowView: View {
    let itemNum: Int
    // @Binding var todo.isDone: Bool
    // @Binding var todo.isStarred: Bool
    // @Binding var todo.isPinned: Bool
    // @Binding var todo.title: String
    // @Binding var todo.notes: String
	@EnvironmentObject var normalViewModel: listViewModel
    @State var showEditSheet: Bool = false
    @State var itemHiding = false
    var body: some View {
        if itemHiding == false {
            HStack {
                ZStack(alignment: .center) {
                    Capsule()
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.gray.opacity(0.7))
                    .frame(width: 27, height: 20)
                    .onTapGesture {
                        withAnimation(.smooth(duration: 0.3)) {
                            normalViewModel.toggleCompletion(item: normalViewModel.todoList[itemNum])
                        }
                    }

                    if normalViewModel.todoList[itemNum].isDone {
                        Capsule()
                            .foregroundStyle(Color("Inner Capsule"))
                            .shadow(radius: 3)
                            .frame(width: 21, height: 15)
                            .onTapGesture {
                                withAnimation(.smooth(duration: 0.3)) {
                                    normalViewModel.toggleCompletion(item: normalViewModel.todoList[itemNum])
                                }
                            }
                            
                    }
                }
                .padding(.trailing, 3)
                
            

                Text(normalViewModel.todoList[itemNum].title)
                    .foregroundStyle(normalViewModel.todoList[itemNum].isDone ? Color.gray : Color.primary)
                    .font(.system(size: 14))
                    .kerning(0.25)
                    .padding(.trailing, 3)

                    .onTapGesture {
                        showEditSheet.toggle()
                    }

                Image(systemName: "text.page")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.gray.opacity(0.8))
                    .opacity(normalViewModel.todoList[itemNum].notes.isEmpty ? 0 : 1)
                    .padding(.horizontal, 0)

                    .onTapGesture {
                        showEditSheet.toggle()
                    }
                
                Spacer()

                Image(systemName: "star.fill")
                    .font(.system(size: 12))
                    .foregroundStyle(normalViewModel.todoList[itemNum].isStarred ? Color.yellow : Color.clear)
                    .padding(.horizontal, 7)
            }
            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button {
                                normalViewModel.togglePin(item: normalViewModel.todoList[itemNum])
                            } label: {
                                Image(systemName: normalViewModel.todoList[itemNum].isPinned ? "pin.slash.fill" : "pin.fill")
                                    .foregroundStyle(normalViewModel.todoList[itemNum].isPinned ? Color.gray.opacity(0.4) : Color.blue)
                            }
                            .tint(normalViewModel.todoList[itemNum].isPinned ? Color(#colorLiteral(red: 0.5647058823529412, green: 0.5647058823529412, blue: 0.5647058823529412, alpha: 1.0)): Color.blue)
                        }
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(role: .destructive) {
                    itemHiding = true
                    normalViewModel.removeItem(item: normalViewModel.todoList[itemNum])
                } label: {
                    Image(systemName: "trash")
                }
                .tint(Color.red)
                
                
                Button {
                    normalViewModel.toggleStar(item: normalViewModel.todoList[itemNum])
                } label: {
                    Image(systemName: normalViewModel.todoList[itemNum].isStarred ?  "star.slash" : "star.fill")
                        .foregroundStyle(normalViewModel.todoList[itemNum].isStarred ? .white : .gray.opacity(0.4))
                }
                .tint(normalViewModel.todoList[itemNum].isStarred ? Color.gray : Color(#colorLiteral(red: 0.8666666666666667, green: 0.7843137254901961, blue: 0.054901960784313725, alpha: 1.0)))
            }
            .sheet(isPresented: $showEditSheet) {
                        editView(showEditSheet: $showEditSheet, object: $normalViewModel.todoList[itemNum])
                            // .environmentObject(normalViewModel)
                        .padding(.top, 15)
                            .presentationDetents([.height(120)])
            }
        } else {
            EmptyView()
        }
    }
}

// #Preview {
// 	@Previewable @State var todo: todoModel = todoModel(todo.title: "Item", todo.isStarred: false, todo.isPinned: false)
// 	listRowView(todo: $todo)
	
// }
