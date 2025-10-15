//
//  NoticeBar.swift
//  todoListVSCODE
//
//  Created by David An on 2025-10-13.
//

import SwiftUI

struct NoticeBar: View {
	
	let style: Bool
	@Binding var showBar: Bool
	@Environment(\.colorScheme) var colorScheme;
	
	@State var expand: Bool = false
	
    var body: some View {
//		Button("toggle") {
//			withAnimation(.smooth(duration: 0.3)) {
//				showBar = true
//			}
//			
//			DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
//				withAnimation(.smooth(duration: 0.3)) {
//					showBar = false
//					expand = false
//				}
//			}
//		}
		if style == false {
			Capsule()
				.foregroundStyle(colorScheme == .dark ? Color(#colorLiteral(red: 0.1317856014, green: 0.1429992318, blue: 0.158118993, alpha: 1)) : Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
				.shadow(radius: 10)
				.animation(.smooth(duration: 0.3), value: showBar)
				.overlay {
					HStack {
						Image(systemName: "link")
							.padding(5)
							.padding(.horizontal, 4)
							.background(
								Capsule()
									.foregroundStyle(colorScheme == .dark ? Color(#colorLiteral(red: 0.7355879545, green: 0, blue: 0.3351337314, alpha: 0.6939645687)) : Color(#colorLiteral(red: 1, green: 0.7218878865, blue: 0.8172422051, alpha: 0.6939645687)))
									.shadow(radius: 4)
							)
							.padding(.leading, 2)
						Spacer()
						VStack(alignment: .trailing) {
							Text("One task")
								.fontWeight(.heavy)
							Text("created")
						}
						.padding(.trailing, 13)
					}
					.fontWeight(.semibold)
					.padding(.horizontal, 8)
					
				}
			// the correction values: .offset(x: 110, y: -30)
				.offset(x: 113, y: showBar ? 330 : 430)
				.frame(width: 160, height: 50)
		} else {
			Capsule()
				.foregroundStyle(colorScheme == .dark ? Color(#colorLiteral(red: 0.1317856014, green: 0.1429992318, blue: 0.158118993, alpha: 1)) : Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
				.shadow(radius: 10)
				.animation(.smooth(duration: 0.3), value: showBar)
				.overlay {
					HStack {
						Image(systemName: "link")
							.padding(5)
							.padding(.horizontal, 4)
							.background(
								Capsule()
									.foregroundStyle(colorScheme == .dark ? Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)) : Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
									.shadow(radius: 4)
							)
							.padding(.leading, 2)
						Spacer()
						VStack(alignment: .trailing) {
							Text("Task")
								.fontWeight(.heavy)
							Text("modified")
						}
						.padding(.trailing, 13)
					}
					.fontWeight(.semibold)
					.padding(.horizontal, 8)
					
				}
			// the correction values: .offset(x: 110, y: -30)
				.offset(x: 113, y: showBar ? 330 : 430)
				.frame(width: 160, height: 50)
		}
		
    }
}

#Preview {
	@Previewable @State var showBar: Bool = true
	@Previewable let style = true
	NoticeBar(style: style, showBar: $showBar
 )
  }
