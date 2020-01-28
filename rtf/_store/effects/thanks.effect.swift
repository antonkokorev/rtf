//
//  thanks.effect.swift
//  rtf
//
//  Created by Anton Elistratov on 14.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import Foundation
import ReSwift
import Alamofire

var thanksEffect: Middleware<AppState> = { dispatch, getState in
	return { next in
		return { action in
			
			guard let thanksInvokedAction = action as? thanksActions else {
				next(action)
				return
			}
			
			/* делает реквест только если pending вызвано */
			switch thanksInvokedAction {
			case .pendingGetThanksCount:
				AF.request(Interceptor.serviceRequest(service: "assessment/thanks/getOverview", body: nil)).response { response in
					/* обработка ошибок */
					switch response.result {
					case .success:
						do {
						let data = try JSONDecoder().decode(IThanks.self, from: response.data!)
							
							next(thanksActions.successGetThanksCount(data))
						} catch {
							print("can't parse data pendingGetThanksCount")
							dispatch(errorActions.errorSuccess("Ошибка обработки данных "))
						}
						break;
					case .failure:
						print("ERROR - result")
						dispatch(errorActions.errorSuccess("Ошибка соединения с сервером"))
						break;
					}
//					switch response.error {
//					case .none:
//						let data = try? JSONDecoder().decode(IThanks.self, from: response.data!)
//						next(thanksActions.successGetThanksCount(data!))
//					case .some(let error):
//						print(error)
//					}
				}
				break
			default:
				break
			}
		}
	}
}
