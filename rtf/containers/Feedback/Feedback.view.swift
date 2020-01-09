//
//  Feedback.swift
//  rtf
//
//  Created by Anton Elistratov on 07.01.2020.
//  Copyright © 2020 team. All rights reserved.
//


import Foundation
import SwiftUI
import Combine

struct FeedbackView : View {
	
	/* reactiveState */
	@ObservedObject var state: UsersRecentState
	let store: GlobalStore 
	
	/* инициализатор store + state перед рендером */
	init(store: GlobalStore) {
		self.store = store
		self.state = store.state.usersRecentSubState
	}
	
	var body: some View {
		VStack{
			Text("Обратная связь")
				.font(Font.custom("SBSansDisplay-SemiBold", size: 25))
				.foregroundColor(.black)
				.multilineTextAlignment(.center)
				.padding()
			
			Text("Запросить или дать обратную свзяь у коллег для развития")
				.padding()
			
			EmployeeSearchBar()
			
			Text("Недавние")
			
			
//							ScrollView (.horizontal) {
			
			HStack {
				ForEach(state.collection) { user in
					User(user: user)
				}
			}
//							}.frame(height: 150)
			
			// NO BUG
			ScrollView (.horizontal) {
				HStack {
					EmployeeIconView(firstName: "Matvey", lastName: "Domozhakov")
					EmployeeIconView(firstName: "Matvey", lastName: "Domozhakov")
					EmployeeIconView(firstName: "Matvey", lastName: "Domozhakov")
					EmployeeIconView(firstName: "Matvey", lastName: "Domozhakov")
					EmployeeIconView(firstName: "Matvey", lastName: "Domozhakov")
				}
			}
			// BUG
			// не отрисовывается
			ScrollView (.horizontal) {
				HStack {
					ForEach(state.collection) { user in
						EmployeeIconView(firstName: user.sFirstName!, lastName: user.sLastName!)
					}
				}
			}
			
			
			HStack {
				Text("Избранное")
				Spacer()
				Text("Изменить")
			}
			
			VStack(alignment: .leading) {
				HStack {
					ForEach(state.collection) { user in
						EmployeeIconView(firstName: user.sFirstName!, lastName: user.sLastName!)
					}
				}
				HStack {
					ForEach(state.collection) { user in
						EmployeeIconView(firstName: user.sFirstName!, lastName: user.sLastName!)
					}
				}
			}
		}
		.onAppear(perform: {
			self.store.dispatch(usersRecentActions.pendingGetRecentUsers)
		})
	}
}

struct FeedbackView_Previews : PreviewProvider {
	static var previews: some View {
		FeedbackView(store: AppMain().store)
	}
}
