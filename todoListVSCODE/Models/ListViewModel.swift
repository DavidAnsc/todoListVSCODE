import Foundation
import SwiftUI

class ListViewModel: ObservableObject {
    @Published var todoList: [TodoModel] {
        didSet {
			DispatchQueue.global(qos: .background).async {
				self.saveData()
			}
			//todoList = todoList.enumerated().filter({ !$0.element.isHidden }).map({ $0.element })
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

        todoList = decodedData
    }

    func saveData() {
        let encodedData = try? JSONEncoder().encode(todoList)
        UserDefaults.standard.set(encodedData, forKey: ListViewModel.dataKey)
    }
	
	func isBeforeToday(in item: TodoModel) -> Bool {
		let cal = Calendar.current
		let startOfToday = cal.startOfDay(for: Date())
		let isBeforeToday = item.dueDate < startOfToday
		
		return isBeforeToday
	}
	
	func getFormattedDate(in item: TodoModel) -> String {
		let date = item.dueDate
		if Calendar.current.isDate(item.dueDate, inSameDayAs: Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))!) {
			let dateFormatter: DateFormatter = {
				let df = DateFormatter()
				df.locale = Locale(identifier: "en_CA") // 🇨🇦 Force Canadian English style
				df.dateFormat = "h:mm a"
				//		df.setLocalizedDateFormatFromTemplate("Mdjm")
				return df
			}()
			return "Tomorrow, " + dateFormatter.string(from: date)
		} else if Calendar.current.isDate(item.dueDate, inSameDayAs: Calendar.current.date(byAdding: .day, value: 0, to: Calendar.current.startOfDay(for: Date()))!) {
			let dateFormatter: DateFormatter = {
				let df = DateFormatter()
				df.locale = Locale(identifier: "en_CA") // 🇨🇦 Force Canadian English style
				df.dateFormat = "h:mm a"
				//		df.setLocalizedDateFormatFromTemplate("Mdjm")
				return df
			}()
			return "Today, " + dateFormatter.string(from: date)
		} else {
			let dateFormatter: DateFormatter = {
				let df = DateFormatter()
				df.locale = Locale(identifier: "en_CA") // 🇨🇦 Force Canadian English style
				df.dateFormat = "MMM d, h:mm a"
				//		df.setLocalizedDateFormatFromTemplate("Mdjm")
				return df
			}()
			
			return dateFormatter.string(from: date)
		}
	}
	
	

	
	
	static func getDoneHaptic() {
		let generator = UIImpactFeedbackGenerator(style: .rigid)
		
		generator.impactOccurred()
	}
	
	static func getCancelHaptic() {
		let generator = UIImpactFeedbackGenerator(style: .light)
		
		generator.impactOccurred()
	}
	
	static func getClickHaptic() {
		let generator = UIImpactFeedbackGenerator(style: .light)
		
		generator.impactOccurred()
	}
	
	static func getErrorHaptic() {
		let generator = UINotificationFeedbackGenerator()
		
		generator.notificationOccurred(.error)
	}
	
    var todayPinned: [TodoModel] {
        todoList.filter { item in
            item.isPinned && !item.isHidden && item.dueDate.isToday
        }
    }

    var todayUnpinned: [TodoModel] {
        todoList.filter { item in
            !item.isPinned && !item.isHidden && item.dueDate.isToday
        }
    }

    var recentPinned: [TodoModel] {
        todoList.filter { item in
            item.isPinned && !item.isHidden
        }
    }

    var recentUnpinned: [TodoModel] {
        todoList.filter { item in
            !item.isPinned && !item.isHidden
        }
    }
	
    init(todoList: [TodoModel]) {
        self.todoList = todoList
    }
}


extension Date {
	var isToday: Bool {
		Calendar.current.isDateInToday(self)
	}
}
