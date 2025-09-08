import SwiftUI

struct editView: View {

    // enum errorType {
    //     case titleSpaceOnly
    //     case titleTooShort
    //     case titleTooLong
    // }
    // @State private var currentError: errorType? = nil

    @State private var objectNotes: String = ""
    @State private var objectTitle: String = ""
    @State private var objectIsStarred: Bool = false
    @State private var objectIsPinned: Bool = false
    // @State var showAlert: Bool = false
    
    @Binding var showEditSheet: Bool
    @Binding var object: todoModel


    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                TextField("Edit the title", text: $objectTitle)
                    .fontDesign(.monospaced)
                    .font(.system(size: 18))
                    .padding(.bottom, 2)
                TextField("Edit notes here", text: $objectNotes)
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
                    object.checkRequirements(objectTitle: objectTitle, objectNotes: objectNotes)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        
                        if !object.showCantCreateAlert {
                            showEditSheet = false
                            object.title = objectTitle
                            object.notes = objectNotes
                            object.isPinned = objectIsPinned
                            object.isStarred = objectIsStarred
                        }
                    }
                    
                    
                } label: {
                    VStack {
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.white)
                            .bold()

                        Text("Save")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 32)
                            .fill(Color.green)
                            .frame(width: 90, height: 90)
                    )
                    
                }
            }
            .padding(.trailing, 20)
        }
        .onAppear {
            objectIsPinned = object.isPinned
            objectIsStarred = object.isStarred
            objectTitle = object.title
            objectNotes = object.notes
        }
        .alert(isPresented: $object.showCantCreateAlert) {
            object.getAlert() ?? Alert(title: Text("Error"))
        }
    }
}