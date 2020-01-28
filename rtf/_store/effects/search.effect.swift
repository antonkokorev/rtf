//
//  search.effect.swift
//  rtf
//
//  Created by Anton Elistratov on 16.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import Foundation
import ReSwift
import Alamofire

var searchEffect: Middleware<AppState> = { dispatch, getState in
	return { next in
		return { action in
			
			guard let userInvokedAction = action as? searchActions else {
				next(action)
				return
			}
			
			/* делает реквест только если pending вызвано */
			switch userInvokedAction {
			case .pendingSearch(let searchTxt):
				
				AF.request(Interceptor.searchRequest(searchTxt: searchTxt)).response { response in
					/* обработка ошибок */
					switch response.result {
					case .success:
						do {
							let data = try JSONDecoder().decode(ISearch.self, from: response.data!)
							
//							if (searchTxt.count > 0 &&  data.iSearchResultSize == 0) {
//								dispatch(errorActions.errorSuccess("Пользователей с таким именем не найдено"))
//							}
							next(searchActions.successSearch(data))
						} catch {
							print("can't parse data pendingSearch")
							dispatch(errorActions.errorSuccess("Ошибка обработки данных"))
						}
						break;
					case .failure:
						print("ERROR - result pendingSearch")
						dispatch(errorActions.errorSuccess("Ошибка соединения с сервером"))
						break
					}
				}
				break
				
			case .displaySearch:
				next(searchActions.displaySearch)
				break
				
			case .hideSearch:
				next(searchActions.hideSearch)
				break
				
			case .resetSearch:
				next(searchActions.resetSearch)
				break
			default:
				break
			}
		}
	}
}
