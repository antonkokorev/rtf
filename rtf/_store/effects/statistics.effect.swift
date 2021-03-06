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


struct IAttrResponce: Codable, Hashable {
    let aObjects:[IAttr]
}




func stringify(json: Any, prettyPrinted: Bool = false) -> String {
    var options: JSONSerialization.WritingOptions = []
    if prettyPrinted {
        options = JSONSerialization.WritingOptions.prettyPrinted
    }
    
    do {
        let data = try JSONSerialization.data(withJSONObject: json, options: options)
        if let string = String(data: data, encoding: String.Encoding.utf8) {
            return string
        }
    } catch {
        print(error)
    }
    
    return ""
}

var statisticsEffect: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            
            guard let statisticsAction = action as? statisticsActions else {
                next(action)
                return
            }
            
            /* делает реквест только если pending вызвано */
            switch statisticsAction {
            case .pendingGetStatisticsAttributes(let id):
                AF.request(Interceptor.serviceRequest(service: "assessment/getItemsForAttributeStatistic",body: stringify(json: ["iSize": 10, "iPage":0, "sAttributeId":id]))).response { response in
                    /* обработка ошибок */
                    switch response.error {
                    case .none:
                        let data = try? JSONDecoder().decode(IAttrResponce.self, from: response.data!)
                        next(statisticsActions.successGetStatisticsAttributes(data!.aObjects))
                    case .some(let error):
                        print(error)
                    }
                }
                break
            case .pendingGetStatisticsCompetencies(let period):
                AF.request(Interceptor.serviceRequest(service: "assessment/getStatisticsForCompetencies",body: stringify(json: ["sDatePeriod": period]))).response { response in
                    /* обработка ошибок */
                    switch response.error {
                    case .none:
                        let data = try? JSONDecoder().decode(IStatColl.self, from: response.data!)
                        
                        next(statisticsActions.successGetStatisticsCompetencies(data!))
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
