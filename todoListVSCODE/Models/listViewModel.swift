import Foundation

class listViewModel: ObservableObject {
    @Published var todoList: [todoModel]


    func toggleCompletion(item: todoModel) {
        if let index = todoList.firstIndex(where: { $0.id == item.id }) {
            todoList[index].isDone.toggle()
        } else {
            print("## Item not found in the list. ##")
        }
    }
    func toggleStar(item: todoModel) {
        if let index = todoList.firstIndex(where: { $0.id == item.id }) {
            todoList[index].isStarred.toggle()
        } else {
            print("## Item not found in the list. ##")
        }
    }
    func togglePin(item: todoModel) {
        if let index = todoList.firstIndex(where: { $0.id == item.id }) {
            todoList[index].isPinned.toggle()
        } else {
            print("## Item not found in the list. ##")
        }
    }

    init(todoList: [todoModel]) {
        self.todoList = todoList
    }
}