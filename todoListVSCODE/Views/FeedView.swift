//
//  FeedView.swift
//  todoListVSCODE
//
//  Created by David An on 2025-09-10.
//

import SwiftUI

struct FeedView: View {
	@State var itemList = ["hello", "goodbye"]
	
	@EnvironmentObject var normalViewModel: listViewModel
	
	@State var cardRotation: Angle = Angle(degrees: 0)
	@State var cardSize: CGFloat = .zero
	@State var cardOffsetX: CGFloat = 0.0
	@State var cardOffsetY: CGFloat = 0.0
	
//	@State var cardRotation1: Angle = Angle(degrees: 0)
//	@State var cardSize1: CGFloat = .zero
	@State var cardOffsetX1: CGFloat = 0.0
	@State var cardOffsetX2: CGFloat = 0.0
	
	@State var stuck = false
	@State var disableDrag = false
	@State var hideRight = false
	@State var hideLeft = false
	
	@State var cardOnChange1: Bool = false
	@State var cardOnChange0: Bool = false
	@State var cardOnChange2: Bool = false
	
	@State var indexN = 0
	var body: some View {
		Text("\(indexN)")
		
		
		HStack {
			ZStack {
				RoundedRectangle(cornerRadius: 32)
					.foregroundStyle(Color.gray.opacity(0.2))
					.frame(width: 220, height: 320)
					.padding()
					.contentShape(Rectangle())
				RoundedRectangle(cornerRadius: 32)
					.stroke(lineWidth: 10)
					.foregroundStyle(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
					.frame(width: 220, height: 320)
					.padding()
					.contentShape(Rectangle())
					
			}
			.rotationEffect(Angle(degrees: -12))
			.scaleEffect(0.70)
			.offset(x: 20+cardOffsetX2, y: 0)
			
			
			ZStack {
				RoundedRectangle(cornerRadius: 32)
					.foregroundStyle(Color.green.opacity(0.3))
					.frame(width: 220, height: 320)
					.padding()
					.contentShape(Rectangle())
					.opacity(stuck ? 0 : 1)
				
				RoundedRectangle(cornerRadius: 32)
					.stroke(lineWidth: 2)
					.foregroundStyle(Color.gray.opacity(0.2))
					.frame(width: 220, height: 320)
					.padding()
					.contentShape(Rectangle())
					.opacity(stuck ? 0 : 1)
				
				
				VStack {
					let bool = normalViewModel.todoList.count > indexN + 1 || indexN < 0
					let currentItem = !bool ? todoModel(title: "ERROR", isStarred: false, isPinned: false) : normalViewModel.todoList[indexN]

					Picker("", selection: (bool) ? $normalViewModel.todoList[indexN].isDone : .constant(false)) {
						Text("Not Started").tag(false)
						Text("Done").tag(true)
					}
					HStack {
						Text(currentItem.title)
					}
//					ForEach(Array(normalViewModel.todoList.enumerated()), id: \.offset) { index, item in
//						if stat == 0 {
//							Text(item.title)
//						}
//					}
					
				}
			}
			.scaleEffect(1 - cardSize)
			.rotationEffect(cardRotation)
			.offset(x: cardOffsetX, y: cardOffsetY)
			.gesture(
				DragGesture()
					.onChanged { value in
						let lateralChange = value.translation.width
						let verticalChange = value.translation.height
						
						
						let valueL = sqrt(abs(lateralChange * 7))
						let valueV = sqrt(abs(verticalChange * 7))
						
						
						// The lateral offset here:
						if lateralChange < 0 {
							withAnimation(.spring(response: 0.15)) {
								cardOffsetX = min(valueL*3.5, 400) * -1
							}
							
						} else {
							withAnimation(.spring(response: 0.15)) {
								cardOffsetX = min(valueL*3.5, 400)
							}
						}
						
						// The rotation here:
						if lateralChange < 0 {
							withAnimation(.spring(response: 0.15)) {
								cardRotation = .init(degrees: valueL * -0.5)
							}
						} else {
							withAnimation(.spring(response: 0.15)) {
								cardRotation = .init(degrees: valueL * 0.5)
							}
						}
						
						// The vertical offset here:
						if verticalChange < 0 {
							withAnimation(.spring(response: 0.15)) {
								cardOffsetY = min(valueV*0.5, 100) * -1
							}
						} else {
							withAnimation(.spring(response: 0.15)) {
								cardOffsetY = min(valueV*0.5, 100)
							}
						}
						
						cardSize = min(abs(lateralChange) / 2 / 200, 0.4)
						
						
						let funcOutput = changePos(value: value)
						if let _ = funcOutput {
							
						} else {
							return
						}
						
						
						
					}
					.onEnded { value in
						
						withAnimation(.spring(response: 0.3)) {
							cardSize = .zero
							cardOffsetX = 0
							cardOffsetY = 0
							cardRotation = .init(degrees: 0)
							let bool = normalViewModel.todoList.count > indexN + 1 || indexN < 0
							if bool {
								indexN += 1
							}
							
							cardOnChange0.toggle()
						}
						
					}
			)
			.disabled(disableDrag)
			
			
			ZStack {
				RoundedRectangle(cornerRadius: 32)
					.foregroundStyle(Color.blue.opacity(0.2))
					.frame(width: 220, height: 320)
					.padding()
					.contentShape(Rectangle())

				RoundedRectangle(cornerRadius: 32)
					.stroke(lineWidth: 10)
					.foregroundStyle(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
					.frame(width: 220, height: 320)
					.padding()
					.contentShape(Rectangle())
					
			}
			.opacity(hideRight ? 0 : 1)
			.rotationEffect(Angle(degrees: 12))
			.scaleEffect(0.70)
			.offset(x: -20+cardOffsetX1, y: 0)
			
			//			RoundedRectangle(cornerRadius: 32)
			//				.frame(width: 220, height: 320)
			//				.padding()
			//				.contentShape(Rectangle())
		}
		
	}
	func changePos(value: DragGesture.Value) -> Int? {
		let lateralChange = value.translation.width
//		let verticalChange = value.translation.height
		
		
		let valueL = sqrt(abs(lateralChange * 7))
//		let valueV = sqrt(abs(verticalChange * 7))
		
		if lateralChange > valueL * 1.2 {
			disableDrag = true
			indexN -= 1
			withAnimation(.spring(response: 0.2)) {
				cardOffsetX = 200
				
				cardOffsetX1 = 20
				stuck = true
				
				
			}
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
				cardOffsetX = -200
				
				cardRotation = .init(degrees: -12)
				cardSize = 0.3
				withAnimation(.spring(response: 0.3)) {
					stuck = false
					cardOffsetX1 = 0
					cardOffsetX2 = 20
					cardOffsetX = 0
					cardRotation = .init(degrees: 0)
					cardSize = 0
				}
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
					withAnimation(.spring(response: 0.3)) {
						cardOffsetX2 = 0
					}
				}
				
			}
			
			disableDrag = false
			return 1
		} else if lateralChange < -valueL * 1.2 && normalViewModel.todoList.count > indexN {
			disableDrag = true
			withAnimation(.spring(response: 0.2)) {
				cardOffsetX = -200
				cardOffsetX2 = -20
				stuck = true
			}
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
				cardOffsetX = 200
				cardRotation = .init(degrees: 12)
				cardSize = 0.3
				withAnimation(.spring(response: 0.3)) {
					stuck = false
					cardOffsetX1 = -20
					cardOffsetX2 = 0
					cardOffsetX = 0
					cardRotation = .init(degrees: 0)
					cardSize = 0
				}
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
					withAnimation(.spring(response: 0.3)) {
						cardOffsetX1 = 0
					}
				}
				
			}
			indexN += 1
			disableDrag = false
			return 1
		} else if normalViewModel.todoList.count <= indexN {
			hideRight = true
			return 1
			
			
		} else {
			return nil
		}
	}
}

#Preview {
	@Previewable @StateObject var normalViewModel = listViewModel(todoList: [todoModel(title: "Item", isStarred: false, isPinned: true), todoModel(title: "Item2", isStarred: false, isPinned: true)])
	FeedView()
		.environmentObject(normalViewModel)
}
