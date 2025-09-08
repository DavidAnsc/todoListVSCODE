import SwiftUI

struct creationView: View {
    @EnvironmentObject var normalViewModel: listViewModel

    @FocusState private var isFocused: Bool
    @FocusState private var isNotesFocused: Bool

    @Binding var showSheet: Bool

    @State private var objectTitle: String = ""
    @State private var objectNotes: String = ""
    @State private var objectIsStarred: Bool = false
    @State private var objectIsPinned: Bool = false
    @State private var currentError: todoModel.errorType? = nil
    @State private var showCantCreateAlert: Bool = false

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                TextField("Enter The Title", text: $objectTitle)
                    .focused($isFocused)
                    .fontDesign(.monospaced)
                    .font(.system(size: 18))
                    .padding(.bottom, 2)
                    .onSubmit {
                        isFocused = false
                        isNotesFocused = true
                    }
                TextField("Notes here", text: $objectNotes)
                    .focused($isNotesFocused)
                    .fontDesign(.rounded)
                    .font(.system(size: 15))
                    .padding(.bottom, 20)
                HStack {
                    Capsule()
                        .frame(width: 60, height: 35)
                        .foregroundColor(objectIsStarred ? .yellow : .gray.opacity(0.2))
                        .overlay(
                            ZStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(objectIsStarred ? .white : .secondary.opacity(0.7))
                            }
                        )
                        .onTapGesture {
                            objectIsStarred.toggle()
                        }
                    Capsule()
                        .frame(width: 60, height: 35)
                        .foregroundColor(objectIsPinned ? .blue : .gray.opacity(0.2))
                        .overlay(
                            ZStack {
                                Image(systemName: "pin.fill")
                                    .foregroundColor(objectIsPinned ? .white : .secondary.opacity(0.7))
                            }
                        )
                        .onTapGesture {
                            objectIsPinned.toggle()
                        }
                }
            }
            .padding(.leading, 20)
            VStack {
                Button {
                    checkRequirements2(objectTitle: objectTitle, objectNotes: objectNotes)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        if !showCantCreateAlert {
                            showSheet = false
                            normalViewModel.addItem(item: todoModel(title: objectTitle, notes: objectNotes, isStarred: objectIsStarred, isPinned: objectIsPinned))
                            isFocused = false
                            objectIsPinned = false
                            objectIsStarred = false
                            objectTitle = ""
                            objectNotes = ""
                            showSheet = false
                        }
                    }
                    
                    

                } label: {
                    VStack {
                        Image(systemName: "return")
                            .foregroundStyle(.white)
                            .bold()

                        Text("Done")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 32)
                            .fill(Color.blue)
                            .frame(width: 90, height: 90)
                    )
                    
                }
            }
            .padding(.trailing, 20)
        }
        .onAppear {
                isFocused = true
        }
        .onDisappear {
            isFocused = false
        }
        .alert(isPresented: $showCantCreateAlert) {
            getAlert() ?? Alert(title: Text("Error"))

        }
    }

    func checkRequirements2(objectTitle: String, objectNotes: String) {
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
}