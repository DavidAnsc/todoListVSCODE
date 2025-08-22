import Foundation

class listViewModel: ObservableObject {
    @Published var todoList: [todoModel] {
        didSet {
            saveData()
        }
    }
    static let dataKey: String = "todoList"

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



    func addItem(item: todoModel) {
        todoList.append(item)
    }

    func removeItem(item: todoModel) {
        if let index = todoList.firstIndex(where: { $0.id == item.id }) {
            todoList.remove(at: index)
        } else {
            print("## Item not found in the list. ##")
        }
        
    }
    



    func getData() {
        guard let data = UserDefaults.standard.data(forKey: listViewModel.dataKey) else { return }
        guard let decodedData = try? JSONDecoder().decode([todoModel].self, from: data) else { return }

        self.todoList = decodedData
    }

    func saveData() {
        let encodedData = try? JSONEncoder().encode(todoList)
        UserDefaults.standard.set(encodedData, forKey: listViewModel.dataKey)
    }





    init(todoList: [todoModel]) {
        self.todoList = todoList
    }
}