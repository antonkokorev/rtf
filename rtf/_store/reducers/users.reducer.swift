//
//  File.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift

struct IUser: Codable, Equatable, Identifiable {
		/* Нужно для Identifiable */
		var id: String {
			return sUserId
		}
    /** ID */
    let sUserId: String
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
}

struct UsersState: StateType {
    var collection = ""
    var status = ""
}

func usersReducer(action: Action, state: UsersState?) -> UsersState {
    var state = state ?? UsersState()

    guard let action = action as? usersActions else {
        return state
    }

    switch action {
    case .pendingGetMe:
        state.status = "[Pending] pendingGetMe"
        break;
    case .successGetMe:
        state.collection = "data blob, state change"
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
