import SwiftUI

struct listRowView: View {
    @Binding var isDone: Bool
    let isStarred: Bool
    let title: String
	
    var body: some View {
        HStack {
            ZStack(alignment: .center) {
                Capsule()
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.gray.opacity(0.7))
                .frame(width: 27, height: 20)
                .onTapGesture {
                    withAnimation(.smooth(duration: 0.3)) {
                        isDone.toggle()
                    }
                }

                if isDone {
                    Capsule()
                        .foregroundStyle(Color("Inner Capsule"))
                        .shadow(radius: 3)
                        .frame(width: 21, height: 15)
                        .onTapGesture {
                            withAnimation(.smooth(duration: 0.3)) {
                                isDone.toggle()
                            }
                        }
                        
                }
            }
            .padding(.trailing, 3)
            
        

            Text(title)
            .foregroundStyle(isDone ? Color.gray : Color.primary)
                .font(.system(size: 14))
                .kerning(0.25)
                .padding(.trailing, 5)
            
            Spacer()

            Image(systemName: "star.fill")
                .font(.system(size: 12))
                .foregroundStyle(isStarred ? Color.yellow : Color.clear)
                .padding(.horizontal, 7)
        }
    }
}

// #Preview {
// 	@Previewable @State var todo: todoModel = todoModel(title: "Item", isStarred: false, isPinned: false)
// 	listRowView(todo: $todo)
	
// }
