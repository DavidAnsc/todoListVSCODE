import Foundation

class listViewModel: ObservableObject {
    @Published var todoList: [todoModel] = []
}