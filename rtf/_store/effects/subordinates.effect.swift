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
					switch response.result {
					case .success:
						do {
							let data = try JSONDecoder().decode(ISubordinates.self, from: response.data!)
							
							next(subordinatesActions.successGetSubordinates(data))
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
