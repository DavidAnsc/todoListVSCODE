import Foundation

struct todoModel: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var isDone: Bool = false
    var isStarred: Bool
    var isPinned: Bool
    
    
    mutating func toggleDone() {
        isDone.toggle()
    }
}