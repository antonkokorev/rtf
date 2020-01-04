//
//  usersRecent.effect.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import Foundation
import ReSwift
import Alamofire


     var userRecentEffect: Middleware<AppState> {
        return { dispatch, getState in { next in return { action in
            print(action)
            next(action)

            AF.request(Interceptor.serviceRequest(service: "relation/recent")).response { response in
                switch response.error {
                case .none:
                    let data = try? JSONDecoder().decode([IUser].self, from: response.data!)
                    next(usersRecentActions.successGetRecentUsers(data!))
                case .some(let error):
                    print(error)
                }
            }
        }}}
    }
