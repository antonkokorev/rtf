//
//  usersRequest.effect.swift
//  rtf
//
//  Created by Anton Elistratov on 14.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import Foundation
import ReSwift
import Alamofire

//struct userRequestEffectPost: Data? {
//	let iPage: Int
//	let iSize: Int
//	let lId: Int
//	let sLoadOption: String
//}

//let userRequestEffectPostBody = userRequestEffectPost(iPage: 0, iSize: 15, lId: 0, sLoadOption: "UNPROCESSED_REQUESTS")

//let json: [String: Any] = ["iPage": 0,
//                           "iSize": 15,
//						   "lId": 0,
//						   "sLoadOption": "UNPROCESSED_REQUESTS"]


let userRequestBody = "{\"iPage\":0, \"iSize\": 15, \"lId\": 0, \"sLoadOption\": \"UNPROCESSED_REQUESTS\"}"

var userRequestEffect: Middleware<AppState> = { dispatch, getState in
	return { next in
		return { action in
			
			guard let userRequestInvokedAction = action as? usersRequestActions else {
				next(action)
				return
			}
			
			/* делает реквест только если pending вызвано */
			switch userRequestInvokedAction {
			case .pendingGetUsersWithRequest:
				AF.request(Interceptor.serviceRequest(service: "relation/allIncome", body: userRequestBody)).response { response in
					/* обработка ошибок */
					switch response.error {
					case .none:
						let data = try? JSONDecoder().decode(IUsersRequest.self, from: response.data!)
						next(usersRequestActions.successGetUsersWithRequest(data!))
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
