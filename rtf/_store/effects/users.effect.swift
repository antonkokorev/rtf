//
//  users.effect.swift
//  rtf
//
//  Created by антон on 14.01.2020.
//  Copyright © 2020 team. All rights reserved.
//


import Foundation
import ReSwift
import Alamofire

var usersEffect: Middleware<AppState> = { dispatch, getState in
	return { next in
		return { action in
			
			guard let userInvokedAction = action as? usersActions else {
				next(action)
				return
			}
			
			/* делает реквест только если pending вызвано */
			switch userInvokedAction {
			case .pendingGetMe:
				
				AF.request(Interceptor.serviceRequest(service: "report/whoAmI",body: nil)).response { response in
					/* обработка ошибок */
					
					switch response.result{
					case .success:
						do {
							let data = try JSONDecoder().decode(IUser.self, from: response.data!)
							
							next(usersActions.successGetMe(data))
						} catch {
							print("can't parse data")
							dispatch(errorActions.errorSuccess("Ошибка обработки данных"))
						}
						break;
					case .failure:
						print("ERROR - result")
						dispatch(errorActions.errorSuccess("Ошибка соединения с сервером"))
						break;
					}
				}
				break
			default:
				break
			}
		}
	}
}

