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
    @State private var objectDueDate: Date = Date()
    @State private var objectIsStarred: Bool = false
    @State private var objectIsPinned: Bool = false
    // @State var showAlert: Bool = false
    
    @State private var startDate: Date = Date.now
    @State private var endDate: Date = Date.now.addingTimeInterval(60*60*24*365*5)



    @Binding var showEditSheet: Bool
    @Binding var object: todoModel
	@Binding var showPicker: Bool


    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                TextField("Edit the title", text: $objectTitle)
                    .fontDesign(.monospaced)
                    .font(.system(size: 18))
                    .padding(.bottom, 2)
                    .padding(.top, 10)
                TextField("Edit notes here", text: $objectNotes)
                    .fontDesign(.rounded)
                    .font(.system(size: 15))
                    .padding(.bottom, 20)
                
                HStack {

                    ZStack {
                        Capsule()
                            .frame(width: 60, height: 35)
                            .foregroundColor(.red)
                            
                        Image(systemName: "calendar")
                                .foregroundColor(.white)
								.padding(5)
								.contentShape(Rectangle())
								.onTapGesture {
									showPicker.toggle()
								}
						if showPicker {
							DatePicker("", selection: $objectDueDate, in: startDate...endDate, displayedComponents: [.date])
								.colorMultiply(Color.clear)
								.frame(width: 60, height: 35)
								
						}
                    }
                    Rectangle()
                        .frame(width: 1, height: 25)
                        .foregroundStyle(Color.gray.opacity(0.5))
                        
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
                .padding(.bottom, 10)
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
                            object.dueDate = objectDueDate
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
            objectDueDate = object.dueDate
            objectTitle = object.title
            objectNotes = object.notes
        }
        .alert(isPresented: $object.showCantCreateAlert) {
            object.getAlert() ?? Alert(title: Text("Error"))
        }
    }
}
