//
//  User.view.swift
//  rtf
//
//  Created by Anton Elistratov on 07.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct User: View {
	
	/* параметр передается от родителя */
	@State var user: IUser
	
	var body: some View {
			Text(user.sFullName!)
	}
}


struct RepositoryListView_Previews : PreviewProvider {
    static var previews: some View {
			User(user:
				IUser(
					sUserId: "matvey",
					sFirstName: "Матвей",
					sMiddleName: nil,
					sLastName: "Доможаков",
					sFullName: "Матвей Доможаков",
					sTitle: nil,
					sStructure: nil,
					iRating: nil,
					bIsMe: nil,
					bIsPinned: nil,
					bIsMyTeam: nil,
					sPhoto: nil,
					sIncomeComment: nil,
					sStatus: nil,
					iIncomeRates: nil,
					IncomeRequests: nil,
					bTypeEstimate: nil,
					sExtidFblock: nil
				)
			)
    }
}
