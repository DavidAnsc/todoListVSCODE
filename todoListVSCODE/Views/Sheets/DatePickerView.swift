//
//  datePickerView.swift
//  todoListVSCODE
//
//  Created by David An on 2025-10-14.
//

import SwiftUI

struct DatePickerView: View {
	@State private var startDate: Date = Date.now.addingTimeInterval(-60*60*24*2)
	@State private var endDate: Date = Date.now.addingTimeInterval(60*60*24*365*5)
	
	@Binding var objectDueDate: Date
    var body: some View {
		DatePicker("", selection: $objectDueDate, in: startDate...endDate)
//			.colorMultiply(Color.red)
			.datePickerStyle(GraphicalDatePickerStyle())
			.tint(Color.teal)
			.scaleEffect(0.85)
    }
}

#Preview {
	@Previewable @State var objectDueDate = Date()
    DatePickerView(objectDueDate: $objectDueDate)
}
