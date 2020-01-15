//
//  usersFavourite.effect.swift
//  rtf
//
//  Created by Anton Elistratov on 14.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import Foundation

import Foundation
import ReSwift
import Alamofire




var usersFavouriteEffect: Middleware<AppState> = { dispatch, getState in
	return { next in
		return { action in
			
			guard let invokedAction = action as? usersFavouriteActions else {
				next(action)
				return
			}
			
			/* делает реквест только если pending вызвано */
			switch invokedAction {
			case .pendingGetFavFeedbackUsers:
				AF.request(Interceptor.serviceRequest(service: "favourite/get", body: nil )).response { response in
					/* обработка ошибок */
					switch response.error {
					case .none:
						let data = try? JSONDecoder().decode([IUser].self, from: response.data!)
						next(usersFavouriteActions.successGetFavFeedbackUsers(data!))
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
