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


//typealias addBody = [{String: String}]

struct addFavBody: Decodable {
	var sUserId: String
}
//let userFavouriteAddBody =

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
					switch response.result {
					case .success:
						do {
							let data = try JSONDecoder().decode([IUser].self, from: response.data!)
							next(usersFavouriteActions.successGetFavFeedbackUsers(data))
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
			/** добавление сотрудников в избранное **/
			case .pendingAddToFav(var sUserId):
				AF.request(Interceptor.serviceRequest(service: "favourite/add", body: "[{\"sUserId\": \(sUserId)}]" )).response { response in
					/* обработка ошибок */
					switch response.result {
					case .success:
						do {
							debugPrint(response)
							let data = try JSONDecoder().decode([addFavBody].self, from: response.data!)
                            //debugPrint(response)
							/** обновляет **/
							dispatch(usersFavouriteActions.pendingGetFavFeedbackUsers)
						} catch {
							print("can't parse data pendingAddToFav")
							dispatch(errorActions.errorSuccess("Ошибка обработки данных"))
						}
						break;
					case .failure:
						print("ERROR - result")
						dispatch(errorActions.errorSuccess("Ошибка соединения с сервером"))
						break;
					}
				}
				break;
			/** удаляет сотрудника из избранного **/
			case .pendingDeleteFromFav(var sUserId):
				AF.request(Interceptor.serviceRequest(service: "favourite/remove", body: "[{\"sUserId\": \(sUserId)}]" )).response { response in
					/* обработка ошибок */
					switch response.result {
					case .success:
						do {
							//debugPrint(response)
							let data = try JSONDecoder().decode([addFavBody].self, from: response.data!)
							/** обновляет **/
							dispatch(usersFavouriteActions.pendingGetFavFeedbackUsers)
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
			default:
				break
			}
		}
	}
}
