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


func userEffect(action:usersActionsNew,this:MyStore){
    switch action {
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
                 print("ERROR - result")
           }
}






func Effects (action: MyAction,  this:MyStore){
    // регистрация эффекта и определиение типа передаваемых данных
        if let _ = action as? usersActionsNew {
             userEffect(action: (action as! usersActionsNew)  , this: this)
        }
    
       }
    
    


func Reduser (action:MyAction, this:MyStore){
        print("reducer : \(action)")
        
        guard let userInvokedAction = action as? usersActionsNew else {
               return
           }
        switch userInvokedAction {
        case .successGetMe(let user):
            
            this.store.states["me"]?.onNext(user)
            break
        default:
            break
        }
        //   print("success\(action) ___  ", payload)
    }




class MyStore:ObservableObject {
    @Published var store:GLStore
    var title:String = ""
    func dispatch (action:MyAction, payload:Any? = nil){
        print("-------------------------pending\(action)--------------------------------")
        Effects(action: action ,this: self)
        Reduser(action: action,  this: self)
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
