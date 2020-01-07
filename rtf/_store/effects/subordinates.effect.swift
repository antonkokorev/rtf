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
				AF.request(Interceptor.serviceRequest(service: "colleagues/subordinates")).response { response in
					/* обработка ошибок */
					switch response.error {
					case .none:
						let data = try? JSONDecoder().decode(IPagination.self, from: response.data!)
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
