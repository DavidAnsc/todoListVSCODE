import SwiftUI

struct CreationView: View {
    @EnvironmentObject var normalViewModel: ListViewModel

    @FocusState private var isFocused: Bool
    @FocusState private var isNotesFocused: Bool

    @Binding var showSheet: Bool
	@Binding var showNoticeBar: Bool

    @State private var objectTitle: String = ""
    @State private var objectNotes: String = ""
    @State private var objectIsStarred: Bool = false
    @State private var objectIsPinned: Bool = false
    @State private var objectDueDate: Date = Date.now
    @State private var currentError: TodoModel.errorType? = nil
    @State private var showCantCreateAlert: Bool = false
	@State private var showDatePicker: Bool = false

    var body: some View {
		ZStack {
			HStack(spacing: 0) {
				VStack(alignment: .leading) {
					TextField("Enter The Title", text: $objectTitle)
						.focused($isFocused)
						.fontDesign(.monospaced)
						.font(.system(size: 18))
						.padding(.bottom, 2)
						.padding(.top, 10)
						.onSubmit {
							isFocused = false
							isNotesFocused = true
						}
					TextField("Notes here", text: $objectNotes)
						.focused($isNotesFocused)
						.fontDesign(.rounded)
						.font(.system(size: 15))
						.padding(.bottom, 20)
					HStack(alignment: .center) {
						ZStack {
							Capsule()
								.frame(width: 60, height: 35)
								.foregroundColor(.red)
								.onTapGesture {
									showDatePicker.toggle()
									isFocused = false
								}
							
							Image(systemName: "calendar")
								.foregroundColor(.white)
							
//							
//							DatePicker("", selection: $objectDueDate, in: startDate...endDate)
//								.colorMultiply(Color.clear)
//								.frame(width: 60, height: 35)
						}
						Rectangle()
							.frame(width: 1, height: 25)
							.foregroundStyle(Color.gray.opacity(0.5))
						// .padding(.leading, 27)
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
								ListViewModel.getCancelHaptic()
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
								ListViewModel.getCancelHaptic()
							}
					}
					.padding(.bottom, 10)
				}
				.padding(.leading, 20)
				.padding(.vertical, 10)
				.padding(.horizontal, 5)
				
				// Rectangle()
				//     .frame(width: 1, height: 90)
				//     .foregroundStyle(Color.gray.opacity(0.5))
				
				
				VStack {
					Button {
						checkRequirements2(objectTitle: objectTitle, objectNotes: objectNotes)
						
						DispatchQueue.main.async {
							if !showCantCreateAlert {
								
								ListViewModel.getClickHaptic()
								
								showSheet = false
								normalViewModel.addItem(item: TodoModel(title: objectTitle, notes: objectNotes, dueDate: objectDueDate, isStarred: objectIsStarred, isPinned: objectIsPinned))
								isFocused = false
								objectIsPinned = false
								objectIsStarred = false
								objectDueDate = Date.now
								objectTitle = ""
								objectNotes = ""
								
								
								
								
								withAnimation(.smooth(duration: 0.3)) {
									showNoticeBar = true
								}
							} else {
								ListViewModel.getErrorHaptic()
							}
						}
						DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
							withAnimation(.smooth(duration: 0.3)) {
								showNoticeBar = false
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
				.padding(.vertical, 10)
				.padding(.horizontal, 5)
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
			.sheet(isPresented: $showDatePicker) {
				DatePickerView(objectDueDate: $objectDueDate)
					.onDisappear {
						isFocused = true
					}
					.padding(.top, 15)
					.presentationDetents([.height(400)])
			}
		}
    }

    func checkRequirements2(objectTitle: String, objectNotes: String) {
        if objectTitle.replacingOccurrences(of: " ", with: "") == "" {
            showCantCreateAlert = true
            currentError = TodoModel.errorType.titleSpaceOnly
            return
        } else if objectTitle.count < 2 {
            showCantCreateAlert = true
            currentError = TodoModel.errorType.titleTooShort
            return
        } else if objectTitle.count > 250 {
            showCantCreateAlert = true
            currentError = TodoModel.errorType.titleTooLong
            return
        } else {
            showCantCreateAlert = false
        }


        if objectNotes.count == 1 {
            showCantCreateAlert = true
            currentError = TodoModel.errorType.noteTooShort
        } else if objectNotes.count > 250 {
            showCantCreateAlert = true
            currentError = TodoModel.errorType.noteTooLong
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


extension UIApplication {
	func endEditing() {
		sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
