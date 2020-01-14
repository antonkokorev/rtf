//
//  subordinates.effect.swift
//  rtf
//
//  Created by Anton Elistratov on 08.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import Foundation
import ReSwift
import Alamofire

let subordinatesBody = "{\"iPage\":0, \"iSize\": 40}"

var subordinatesEffect: Middleware<AppState> = { dispatch, getState in
	return { next in
		return { action in
			
			guard let subordinatesInvokedAction = action as? subordinatesActions else {
				next(action)
				return
			}

			/* делает реквест только если pending вызвано */
			switch subordinatesInvokedAction {
			case .pendingGetSubordinates:
				AF.request(Interceptor.serviceRequest(service: "colleagues/subordinates", body: subordinatesBody)).response { response in
					/* обработка ошибок */
					switch response.error {
					case .none:
						let data = try? JSONDecoder().decode(ISubordinates.self, from: response.data!)
						next(subordinatesActions.successGetSubordinates(data!))
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
