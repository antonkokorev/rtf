//
//  competencies.effect.swift
//  rtf
//
//  Created by Anton Elistratov on 29.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import Foundation
import ReSwift
import Alamofire

var competenciesEffect: Middleware<AppState> = { dispatch, getState in
	return { next in
		return { action in
			
			guard let userRecentInvokedAction = action as? competenciesActions else {
				next(action)
				return
			}
			
			/* делает реквест только если pending вызвано */
			switch userRecentInvokedAction {
			case .pendingGetCompetencies:
				AF.request(Interceptor.serviceRequest(service: "attribute/getCompetencies", body: nil )).response { response in
					/* обработка ошибок */
					switch response.result {
					case .success:
						do {
							let data = try JSONDecoder().decode([IFullCompetence].self, from: response.data!)
							print(response)
							next(competenciesActions.successGetCompetencies(data))
						} catch {
							debugPrint(response)
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
