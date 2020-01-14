//
//  usersRecent.effect.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import Foundation
import ReSwift
import Alamofire

var userRecentEffect: Middleware<AppState> = { dispatch, getState in
	return { next in
		return { action in
			
			guard let userRecentInvokedAction = action as? usersRecentActions else {
				next(action)
				return
			}
			
			/* делает реквест только если pending вызвано */
			switch userRecentInvokedAction {
			case .pendingGetRecentUsers:
				AF.request(Interceptor.serviceRequest(service: "relation/recent", body: nil )).response { response in
					/* обработка ошибок */
					switch response.error {
					case .none:
						let data = try? JSONDecoder().decode([IUser].self, from: response.data!)
						next(usersRecentActions.successGetRecentUsers(data!))
					case .some(let error):
						print(error)
					}
				}
				break
			default:
				break
			}
		}
	}
}
