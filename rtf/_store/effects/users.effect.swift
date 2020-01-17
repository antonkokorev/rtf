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
                    switch response.error {
                    case .none:
              
                        let data = try? JSONDecoder().decode(IUser.self, from: response.data!)
                      
                        next(usersActions.successGetMe(data!))
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

