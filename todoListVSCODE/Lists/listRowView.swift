import SwiftUI

struct listRowView: View {
    let todo: todoModel
    var body: some View {
        HStack {
            ZStack(alignment: .center) {
                Capsule()
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.gray.opacity(0.7))
                .frame(width: 27, height: 20)

                if todo.isDone {
                    Capsule()
                        .foregroundStyle(Color("Inner Capsule"))
                        .shadow(radius: 3)
                        .frame(width: 21, height: 15)
                }
            }
            .padding(.trailing, 3)
            
        

            Text(todo.title)
            .foregroundStyle(todo.isDone ? Color.gray : Color.primary)
                .font(.system(size: 14))
                .kerning(0.25)
            
            Spacer()

            Image(systemName: "star.fill")
                .font(.system(size: 12))
                .foregroundStyle(todo.isStarred ? Color.yellow : Color.clear)
                .padding(.horizontal, 7)
        }
    }
}
