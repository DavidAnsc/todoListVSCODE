import Foundation
import SwiftUI

class ListViewModel: ObservableObject {
    @Published var todoList: [TodoModel] {
        didSet {
            saveData()
        }
    }
    static let dataKey: String = "todoList"


    
    func getItemByID(id: String) -> TodoModel? {
        return todoList.first(where: { $0.id == id })
    }


    func toggleCompletion(item: TodoModel) {
        if let index = todoList.firstIndex(where: { $0.id == item.id }) {
            todoList[index].isDone.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.todoList.sort { first, second in
                    if first.isPinned == second.isPinned {
                        return !first.isDone && second.isDone
                    }
                    return first.isPinned && !second.isPinned
                }
            }
        } else {
            print("## item not found in the list. ##")
        }
    }
    func toggleStar(item: TodoModel) {
        if let index = todoList.firstIndex(where: { $0.id == item.id }) {
            todoList[index].isStarred.toggle()
        } else {
            print("## item not found in the list. ##")
        }
    }
    func togglePin(item: TodoModel) {
        if let index = todoList.firstIndex(where: { $0.id == item.id }) {
            todoList[index].isPinned.toggle()
        } else {
            print("## item not found in the list. ##")
        }
    }
	func toggleHidden(item: TodoModel) {
		if let index = todoList.firstIndex(where: { $0.id == item.id }) {
			todoList[index].isHidden.toggle()
		} else {
			print("## item not found in the list")
		}
	}



    func addItem(item: TodoModel) {
        todoList.append(item)
    }

    func removeItem(item: TodoModel) {
        if let index = todoList.firstIndex(where: { $0.id == item.id }) {
            todoList.remove(at: index)
        } else {
            print("## Item not found in the list. ##")
        }
    }

    func moveItem(from: IndexSet, to: Int) {
        todoList.move(fromOffsets: from, toOffset: to)
    }
    



    func getData() {
        guard let data = UserDefaults.standard.data(forKey: ListViewModel.dataKey) else { return }
        guard let decodedData = try? JSONDecoder().decode([TodoModel].self, from: data) else { return }

        self.todoList = decodedData
    }

    func saveData() {
        let encodedData = try? JSONEncoder().encode(todoList)
        UserDefaults.standard.set(encodedData, forKey: ListViewModel.dataKey)
    }


	
	
	static func getDoneHaptic() {
		let generator = UIImpactFeedbackGenerator(style: .rigid)
		
		generator.impactOccurred()
	}
	
	static func getCancelHaptic() {
		let generator = UIImpactFeedbackGenerator(style: .light)
		
		generator.impactOccurred()
	}
	
	


    init(todoList: [TodoModel]) {
        self.todoList = todoList
    }
}
