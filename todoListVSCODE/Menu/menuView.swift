import SwiftUI

struct menuView: View {
    @Binding var showMenu: Bool


    @State var XoffsetAmount: CGFloat = 0
    @State var yOffset: CGFloat = 0
	@State var barInChange = false
	var body: some View {
		NavigationStack {
			if showMenu {
				Group {
					ZStack(alignment: .leading) {
						Rectangle()
							.ignoresSafeArea()
							.opacity(showMenu ? 0.25 : 0)
							.onTapGesture {
								withAnimation(.smooth(duration: 0.3)) {
									showMenu = false
									XoffsetAmount = 0
								}
							}
						ZStack {							
							HStack {
								ZStack {
									VStack(alignment: .center) {
										ZStack {
											Label("Today", systemImage: "calendar.circle.fill")
												.font(.headline)
											NavigationLink("1", destination: TodayView())
												.padding()
												.foregroundStyle(Color.clear)
												.contentShape(Rectangle())
										}
										ZStack {
											Label("All Todos", systemImage: "list.bullet.circle.fill")
												.font(.headline)
											NavigationLink("2", destination: ListView())
												.padding()
												.foregroundStyle(Color.clear)
												.contentShape(Rectangle())
										}
										ZStack {
											Label("Feed", systemImage: "lanyardcard.fill")
												.font(.headline)
											NavigationLink("3", destination: FeedView())
												.padding()
												.foregroundStyle(Color.clear)
												.contentShape(Rectangle())
										}
									}
									.frame(width: 150, height: 190)
									.background(.ultraThinMaterial)
									.cornerRadius(32)
									.padding(.trailing, 7)
									.offset(x: XoffsetAmount, y: yOffset)
									
									RoundedRectangle(cornerRadius: 32)
										.stroke(lineWidth: 2)
										.foregroundStyle(Color.gray.opacity(0.6))
										.frame(width: 150, height: 190)
										.padding(.trailing, 7)
										.offset(x: XoffsetAmount, y: yOffset)
								}
								
								
								Capsule()
									.foregroundStyle(Color.gray.opacity(0.6))
									.frame(width: 12, height: barInChange ? 53 : 45)
									.offset(x: XoffsetAmount, y: yOffset)
									.padding(.trailing, 20)
									.padding(.vertical, 15)
									.contentShape(Rectangle())
								
									.gesture(
										DragGesture()
											.onChanged { value in
												barInChange = true
												let valueWidth = value.translation.width
												let heightTranslation = value.translation.height
												if heightTranslation < 0 {
													yOffset = min(sqrt(abs(heightTranslation)), 20) * -1
												} else if heightTranslation > 0 {
													yOffset = min(sqrt(abs(heightTranslation)), 20)
												} else {
													yOffset = 0
												}
												if valueWidth > 0 {
													XoffsetAmount = min(sqrt(valueWidth), 18)
												} else if valueWidth < 0 {
													XoffsetAmount = min(abs(valueWidth)*0.7, 120) * -1
													
												}
												
												
											}
										
											.onEnded { finalValue in
												withAnimation(.smooth(duration: 0.3)) {
													// no conditional
													yOffset = 0
													barInChange = false
													// no conditional
													
													XoffsetAmount = 0
													
												}
												if finalValue.translation.width < -105 {
													withAnimation(.smooth(duration: 0.3)) {
														showMenu = false
													}
												}
											}
									)
								
								
							}
						}
						.offset(y:-200)
						.padding(.leading, 10)
						.transition(.opacity)
					}
				}
			}
				
		}
	}
}


//#Preview {
//	@Previewable @State var showMenu: Bool = false
//	menuView(showMenu: $showMenu)
//}
