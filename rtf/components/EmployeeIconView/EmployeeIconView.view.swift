//
//  EmployeeIconView.swift
//  rtf
//
//  Created by Anton Elistratov on 08.01.2020.
//  Copyright © 2020 team. All rights reserved.
//
import SwiftUI

struct EmployeeIconView: View {
	
	@State var firstName: String
	@State var lastName: String
	
	var body: some View {
		VStack(alignment: .center) {
			Circle()
			Text(firstName)
			Text(lastName)
		}
		.frame(height: 150)
	}
}

struct EmployeeIconView_Preview: PreviewProvider {
	static var previews: some View {
			EmployeeIconView(firstName: "Матвей", lastName: "Доможаков")
	}
}
