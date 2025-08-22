import SwiftUI

struct creationView: View {
    @EnvironmentObject var normalViewModel: listViewModel

    @FocusState private var isFocused: Bool

    @Binding var showSheet: Bool

    @State private var objectTitle: String = ""
    @State private var objectIsStarred: Bool = false
    @State private var objectIsPinned: Bool = false

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                TextField("Enter The Title", text: $objectTitle)
                    .focused($isFocused)
                    .fontDesign(.monospaced)
                    .font(.system(size: 18))
                    .padding(.bottom, 20)
                HStack {
                    Capsule()
                        .frame(width: 60, height: 35)
                        .foregroundColor(objectIsStarred ? .yellow : .gray.opacity(0.2))
                        .overlay(
                            ZStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(objectIsStarred ? .white : .white.opacity(0.7))
                                Image(systemName: "star")
                                    .foregroundColor(.white.opacity(0.7))
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
                                    .foregroundColor(objectIsPinned ? .white : .white.opacity(0.7))
                                Image(systemName: "pin")
                                    .foregroundColor(.white.opacity(0.7))
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
                    normalViewModel.addItem(
                        item: todoModel(title: objectTitle, isStarred: objectIsStarred, isPinned: objectIsPinned)
                    )
                    isFocused = false
                    objectIsPinned = false
                    objectIsStarred = false
                    objectTitle = ""
                    showSheet = false

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
    }
}