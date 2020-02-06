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





//func userService (_ url: String,_ this: MyStore) -> DataRequest? {
//	AF.request(Interceptor.serviceRequest(service: "report/whoAmI",body: nil))
//		.response(completionHandler:  { response  in
//			switch response.result{
//			case .success:
//				do {
//					let data = try JSONDecoder().decode(IUser.self, from: response.data!)
//
//
//					// print(data)
////					return data
////					this.dispatch(action: usersActionsNew.successGetMe(data),payload: data)
//					//  next(usersActions.successGetMe(data)
//
//				} catch {
//					print("can't parse data pendingGetMe")
//
//					//   dispatch(errorActions.errorSuccess("Ошибка обработки данных"))
//				}
//				break;
//			case .failure:
//				print("ERROR - result")
//				// dispatch(errorActions.errorSuccess("Ошибка соединения с сервером"))
//				break;
//			}
//		});
//}

//func userEffect(action:usersActionsNew,this:MyStore){
//
////	guard let userInvokedAction = action as? usersActionsNew else {
////		next(action)
////		return
////	}
//
//    switch action {
//           case .pendingGetMe:
//			UsersService()
//				.getData("report/whoAmI")
//				.subscribe(
//				onNext: { friends in
//					/** прокидывание дальше **/
//					this.dispatch(action: usersActionsNew.successGetMe(friends), payload: friends)
//				})
//
//           default:
//                 print("ERROR - result")
//           }
//}





let disposeBag = DisposeBag()
func Effects (action: MyAction,  this:MyStore){
	
	
	// регистрация эффекта и определиение типа передаваемых данных
	if let invokedAction = action as? usersActionsNew {
		
		//             userEffect(action: (action as? usersActionsNew)!  , this: this)
		
		switch invokedAction {
		case .pendingGetMe:
			UsersService()
				.getData("report/whoAmI")
				.subscribe(
					onNext: { data in
						/** прокидывание дальше **/
						this.dispatch(action: usersActionsNew.successGetMe(data), payload: data)
				}).disposed(by: disposeBag)
			
			//				.map{ innerValue -> IUser in
			//
			//					print("USER")
			//					print(innerValue)
			//					return innerValue
			//			}
			
			//				.subscribe(
			//					onNext: { data in
			//						/** прокидывание дальше **/
			//						this.dispatch(action: usersActionsNew.successGetMe(data), payload: data)
			//				})
			
		default:
			print("ERROR - result")
		}
		
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


/** Пример сервиса **/
class UsersService {
	enum ErrorCodes: Int, Error {
		case unAuthorized = 401
		case notFound = 404
	}
	
	func getData(_ url: String) -> Observable<IUser> {
		
		return Observable.create { observer -> Disposable in
			AF.request(Interceptor.serviceRequest(service: url, body: nil))
				.validate()
				.responseJSON { response in
					switch response.result {
					case .success:
						guard let data = response.data else {
							
							observer.onError(response.error ?? ErrorCodes.notFound)
							return
						}
						do {
							let data = try JSONDecoder().decode(IUser.self, from: data)
							
							observer.onNext(data)
						} catch {
							observer.onError(error)
						}
					case .failure(let error):
						if let statusCode = response.response?.statusCode,
							let reason = ErrorCodes(rawValue: statusCode)
						{
							observer.onError(reason)
						}
						observer.onError(error)
					}
			}
			
			return Disposables.create()
		}
	}
}
