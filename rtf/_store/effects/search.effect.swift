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
                    switch response.error {
                    case .none:
						
                        let data = try? JSONDecoder().decode(ISearch.self, from: response.data!)
//						print(response.value)
						if ((data) != nil) {
//							debugPrint(response)
//							print(data!)
							next(searchActions.successSearch(data!))
						} else {
							print("Error")
//							debugPrint(response)
						}

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
