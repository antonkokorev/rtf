//
//  usersHistory.effect.swift
//  rtf
//
//  Created by антон on 14.01.2020.
//  Copyright © 2020 team. All rights reserved.
//


import Foundation
import ReSwift
import Alamofire

var userHistoryEffect: Middleware<AppState> = { dispatch, getState in
	return { next in
		return { action in
			
			guard let userRecentInvokedAction = action as? usersHistoryActions else {
				next(action)
				return
			}
			
			/* делает реквест только если pending вызвано */
			switch userRecentInvokedAction {
			case .pendingGetUserHistory:
				
				AF.request(Interceptor.serviceRequest(service: "asessment/historyList", body: nil)).response { response in
					/* обработка ошибок */
					switch response.result {
					case .success:
						do {
							let data = try JSONDecoder().decode(IUserHistory.self, from: response.data!)
							
							next(usersHistoryActions.successGetUserHistory(data))
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

