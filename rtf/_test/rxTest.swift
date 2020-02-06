//
//  rxTest.swift
//  rtf
//
//  Created by антон on 03.02.2020.
//  Copyright © 2020 team. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

enum testActions:MyAction {
    case pendingGetBoss(String)
    case successGetBoss
}



public protocol MyAction { }

struct IAction {
    var name:String
    var Data:Any
}

struct Effects {
    func getUserData(action: MyAction,  this:MyStore){
//        guard let userInvokedAction = payload as? usersActions else {
//                    
//                    return
//                }
      guard let userInvokedAction = action as? usersActionsNew else {
   
          return
      }
        
        //print("effect : \(action)")
        switch userInvokedAction {
        case .pendingGetMe:
            AF.request(Interceptor.serviceRequest(service: "report/whoAmI",body: nil))
                .response(completionHandler:  { response  in
                    switch response.result{
                    case .success:
                        do {
                            let data = try JSONDecoder().decode(IUser.self, from: response.data!)
                            // print(data)
                            this.dispatch(action: usersActionsNew.successGetMe(data),payload: data)
                            //  next(usersActions.successGetMe(data))
                        } catch {
                            print("can't parse data pendingGetMe")
                            
                            //   dispatch(errorActions.errorSuccess("Ошибка обработки данных"))
                        }
                        break;
                    case .failure:
                        print("ERROR - result")
                        // dispatch(errorActions.errorSuccess("Ошибка соединения с сервером"))
                        break;
                    }
                });
            break
            
        default:
            ""
        }}
    
    
}

struct Reduser {
    func getUserData(action:MyAction, this:MyStore){
        print("reducer : \(action)")
        
        guard let userInvokedAction = action as? usersActionsNew else {
        
               return
           }
        switch userInvokedAction {
        case .successGetMe(let user):
            
            print("")
            this.store.states["me"]?.onNext(user)
            break
        default:
            break
        }
        //   print("success\(action) ___  ", payload)
    }
}



class MyStore:ObservableObject {
    @Published var store:GLStore
    var title:String = ""
    func dispatch (action:MyAction, payload:Any? = nil){
        print("-------------------------pending\(action)--------------------------------")
        Effects().getUserData(action: action ,this: self)
        Reduser().getUserData(action: action,  this: self)
    }
    init(store:GLStore){
        self.store = store
    }
    
}

/** конфигурация стора, все файлы в state.swift **/
let mStore = GLStore(states:[
    "me": BehaviorSubject(value: initIUser()),
    "history":BehaviorSubject(value: usersHistoryStateS())])

open class GLStore{
    let states : [String:BehaviorSubject<Any>]
    init (states:[String:BehaviorSubject<Any>]){
        self.states = states
    }
}
