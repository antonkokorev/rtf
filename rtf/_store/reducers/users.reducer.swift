//
//  File.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift
import Combine
import SwiftUI

struct IUser: Codable, Equatable, Identifiable, Hashable {
	/* Нужно для Identifiable */
	let id = UUID()
    /** ID */
    let sUserId: String?
    /** Имя */
    let sFirstName: String?
    /** Фамилия */
    let sMiddleName: String?
    /** Отчество */
    let sLastName: String?
    /** Полное имя */
    let sFullName: String?
    /** Должность */
    let sTitle: String?
    /** Функциональный блок */
    let sStructure: String?
    /** Рейтинг */
    let iRating: Int?
    /* я ли это?*/
    let bIsMe: Bool?
    /** Тип */
    let bIsPinned: Bool?
    /** Принадлежность к команде текущего пользователя */
    let bIsMyTeam: Bool?;
    /** Фото */
    let sPhoto: String?;
    /** ????? */
    let sIncomeComment: String?;
    /** Статус (прочитано, просмотрено и тп) */
    let sStatus: String?;
    /** Число входящих оценок */
    let iIncomeRates: Int?;
    /** Число входящих запросов */
    let IncomeRequests: Int?;
    /** Входящие или исходящие оценки, true - входящие, false - исходящие */
    let bTypeEstimate: Bool?;
    /** Функциональный блок */
    let sExtidFblock: String?;
	/**  **/
	let bAddButton: Bool?

}
func initIUser()-> IUser{
    return IUser(
        sUserId: "",
        sFirstName: "",
        sMiddleName: nil,
        sLastName: nil,
        sFullName: nil,
        sTitle: nil,
        sStructure: nil,
        iRating: nil,
        bIsMe: nil,
        bIsPinned: nil,
        bIsMyTeam: nil,
        sPhoto: "",
        sIncomeComment: nil,
        sStatus: nil,
        iIncomeRates: nil,
        IncomeRequests: nil,
        bTypeEstimate: nil,
        sExtidFblock: nil,
		bAddButton: false
    )
}

final class UsersState: StateType, ObservableObject {
	@Published var sUserId: String = ""
    @Published var me: IUser = initIUser()
    @Published var status = ""
}


func usersReducer(action: Action, state: UsersState?) -> UsersState {
    let state = state ?? UsersState()

    guard let action = action as? usersActions else {
        return state
    }

//	print("red", action)
    switch action {
    case .pendingGetMe:
        state.status = "[Pending] pendingGetMe"
        break;
    case .successGetMe(let me):
        state.me = me
		state.sUserId = me.sUserId!
        state.status = "[Success] successGetMe"
        break;
    case .pendingGetUserById:
        state.status = "[Pending] pendingGetUserById"
        break;
    case .pendingCurrentUser:
        state.status = "[Pending] pendingCurrentUser"
        break;
    case .setCurrentUser:
        state.status = "[Set] setCurrentUser"
        break;
    case .setActiveUser:
        state.status = "[Set] setActiveUser"
        break;
    case .setAssessmentsCount:
        state.status = "[Set] setAssessmentsCount"
        break;
    case .filterActiveList:
        state.status = "[Filter] filterActiveList"
        break;
    }
    
    return state;
}
