import SwiftUI

struct menuView: View {
	
//	init(showMenu: Binding<Bool>){
//		UINavigationBar.setAnimationsEnabled(false)
//		self._showMenu = showMenu
//	}
	
    @Binding var showMenu: Bool
	
	@Namespace var zoomTransition1
	@Namespace var zoomTransition2

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
							.foregroundStyle(Color.black)
							.onTapGesture {
								showMenu = false
								XoffsetAmount = 0
							}
						ZStack {							
							HStack {
								ZStack {
									VStack(alignment: .leading) {
										NavigationLink {
											TodayView()
												.navigationTransition(.zoom(sourceID: "zoomTransition1", in: zoomTransition1))
										} label: {
											Label("Today", systemImage: "calendar.circle.fill")
											.font(.headline)
											.padding(4)
											.contentShape(RoundedRectangle(cornerRadius:4))
											.foregroundStyle(Color.primary)
											.matchedTransitionSource(id: "zoomTransition1", in: zoomTransition1)
										}
										.padding(.top, 15)
										.onTapGesture {
											ListViewModel.getCancelHaptic()
										}
										

										Spacer()

										NavigationLink {
											RecentView()
												.navigationTransition(.zoom(sourceID: "zoomTransition2", in: zoomTransition2))
										} label: {
											Label("Recent", systemImage: "list.bullet.circle.fill")
											.font(.headline)
											.padding(4)
											.contentShape(RoundedRectangle(cornerRadius:4))
											.foregroundStyle(Color.primary)
											.matchedTransitionSource(id: "zoomTransition2", in: zoomTransition2)
										}
										.padding(.bottom, 15)
										.onTapGesture {
											ListViewModel.getCancelHaptic()
										}
										
										
									}
									.frame(width: 150, height: 120)
									.background(.ultraThinMaterial)
									.cornerRadius(32)
									.padding(.trailing, 7)
									.offset(x: XoffsetAmount, y: yOffset)
									
									RoundedRectangle(cornerRadius: 32)
									
										.stroke(lineWidth: 2)
										.foregroundStyle(Color.gray.opacity(0.6))
										.frame(width: 150, height: 120)
										.padding(.trailing, 7)
										.offset(x: XoffsetAmount, y: yOffset)
								}
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
								
								
								// Capsule()
								// 	.foregroundStyle(Color.gray.opacity(0.6))
								// 	.frame(width: 12, height: barInChange ? 53 : 45)
								// 	.offset(x: XoffsetAmount, y: yOffset)
								// 	.padding(.trailing, 20)
								// 	.padding(.vertical, 15)
								// 	.contentShape(Rectangle())
								
									
								
								
							}
						}
						.offset(y:-255)
						.padding(.leading, 10)
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

