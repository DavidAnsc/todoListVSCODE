import Foundation

@Observable
class todoModel: Identifiable, Encodable, Decodable {
    var id: String = UUID().uuidString
    var title: String
    var notes: String = ""
    var isDone: Bool = false
    var isStarred: Bool
    var isPinned: Bool
    
    
    func toggleDone() {
        self.isDone.toggle()
    }

    init(title: String, notes: String, isStarred: Bool, isPinned: Bool) {
        self.title = title
        self.notes = notes
        self.isStarred = isStarred
        self.isPinned = isPinned
    }

    
}