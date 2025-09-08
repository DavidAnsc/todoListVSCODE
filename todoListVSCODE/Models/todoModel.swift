import Foundation
import SwiftUI

struct todoModel: Identifiable, Encodable, Decodable {
    var id: String = UUID().uuidString
    var title: String
    var notes: String = ""
    var isDone: Bool = false
    var isStarred: Bool
    var isPinned: Bool
    
    enum errorType: Encodable, Decodable {
        case titleSpaceOnly
        case titleTooShort
        case titleTooLong

        case noteTooShort
        case noteTooLong
    }
    
    var currentError: errorType? = nil
    var showCantCreateAlert: Bool = false
    
    mutating func toggleDone() {
        self.isDone.toggle()
    }


    mutating func checkRequirements(objectTitle: String, objectNotes: String) {
        if objectTitle.replacingOccurrences(of: " ", with: "") == "" {
            showCantCreateAlert = true
            currentError = todoModel.errorType.titleSpaceOnly
            return
        } else if objectTitle.count < 2 {
            showCantCreateAlert = true
            currentError = todoModel.errorType.titleTooShort
            return
        } else if objectTitle.count > 250 {
            showCantCreateAlert = true
            currentError = todoModel.errorType.titleTooLong
            return
        } else {
            showCantCreateAlert = false
        }


        if objectNotes.count == 1 {
            showCantCreateAlert = true
            currentError = todoModel.errorType.noteTooShort
        } else if objectNotes.count > 250 {
            showCantCreateAlert = true
            currentError = todoModel.errorType.noteTooLong
        } else {
            showCantCreateAlert = false
        }
    }


    func getAlert() -> Alert? {
        if !showCantCreateAlert { return nil }
        switch currentError {
            case .titleSpaceOnly:
                return Alert(title: Text("Can't create todo"), 
                    message: Text("The title can't be just spaces."), 
                    dismissButton: .default(Text("OK")))
            case .titleTooShort:
                return Alert(title: Text("Can't create todo"), 
                    message: Text("The title can't be just one letter."), 
                    dismissButton: .default(Text("OK")))
            case .titleTooLong:
                return Alert(title: Text("Can't create todo"), 
                        message: Text("The title can't be above 250 letters."), 
                        dismissButton: .default(Text("OK")))
            case .noteTooShort:
                return Alert(title: Text("Can't create todo"), 
                    message: Text("The note can't be just one letter."), 
                    dismissButton: .default(Text("OK")))
            case .noteTooLong:
                return Alert(title: Text("Can't create todo"), 
                        message: Text("The note can't be above 250 letters."), 
                        dismissButton: .default(Text("OK")))
            case .none:
                return nil
            }
    }




    init(title: String, notes: String, isStarred: Bool, isPinned: Bool) {
        self.title = title
        self.notes = notes
        self.isStarred = isStarred
        self.isPinned = isPinned
    }

    
}