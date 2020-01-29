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

var feedbackPropsEffect: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            
            guard let feedbackPropsActions_ = action as? feedbackPropsActions else {
                next(action)
                return
            }
            
            /* делает реквест только если pending вызвано */
            switch feedbackPropsActions_ {
            case .pendingGetAllCompetences:
                AF.request(Interceptor.serviceRequest(service: "attribute/getCompetencies", body: nil)).response { response in
                    /* обработка ошибок */
                    switch response.result {
                    case .success:
                        do {
                              
                        let data = try JSONDecoder().decode([ICompetentions].self, from: response.data!)
                         
                            next(feedbackPropsActions.successGetAllCompetences(data))
                        } catch {
                            print("can't parse data pendingGetAllCompetences")
                            dispatch(errorActions.errorSuccess("Ошибка обработки данных "))
                        }
                        break;
                    case .failure:
                        print("ERROR - result")
                        dispatch(errorActions.errorSuccess("Ошибка соединения с сервером"))
                        break;
                    }
//                    switch response.error {
//                    case .none:
//                        let data = try? JSONDecoder().decode(IThanks.self, from: response.data!)
//                        next(thanksActions.successGetThanksCount(data!))
//                    case .some(let error):
//                        print(error)
//                    }
                }
                break
            default:
                break
            }
        }
    }
}
