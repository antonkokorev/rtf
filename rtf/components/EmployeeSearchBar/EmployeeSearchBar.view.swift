//
//  EmployeeSearchBar.view.swift
//  rtf
//
//  Created by Anton Elistratov on 07.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct EmployeeSearchBar: View {
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 29)
				.frame(height: 45)
				.foregroundColor(Color(red:0.93, green:0.94, blue:0.97))
				.padding()
			
			HStack {
				Image(systemName: "magnifyingglass")
				Text("Поиск по ФИО")
				Spacer()
			}
			.padding(.leading, CGFloat(30))
		}
	}
}

struct EmployeeSearchBar_Preview: PreviewProvider {
	static var previews: some View {
			EmployeeSearchBar()
	}
}
