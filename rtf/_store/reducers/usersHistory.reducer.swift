//
//  usersHistory.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift
import Combine
import SwiftUI

struct IUserHistoryList: Codable, Equatable, Hashable{
    let  oRequester:IUser
}

struct IAttributeToCategory: Codable, Equatable, Hashable{
    let sAttributeId:String
    let sCategoryId:String
}
struct ISkill: Codable, Equatable, Hashable{
    let sId:String
}

struct IPersonAssesmentItem: Codable, Equatable, Hashable {
    let sId:String?
    let sPersonAssessmentId:String?
    let oAttributeToCategory:IAttributeToCategory?
    let oSkill:ISkill?
    let iGrade:Double?
    let bActive:Bool?
    let sRespondentComment:String?
    let sCanNotAnswerType:String?
    let sCanNotAnswerText:String?
}

struct IOProject: Codable, Equatable, Hashable  {
    let sId: String?
    let sRequesterId: String?
    let lCreationTime: Double?
    let sDescription: String?
    let sName: String?
    let sStatus: String?
}

struct IUserPayload: Codable, Equatable, Hashable {
    let sId: String?
    let sRequesterId: String?
    let sRespondentId: String?
    let lCreationTime: Int64?
    let sRequesterComment: String?
    let lResponseTime: CLong?
    let sStatus:String?
    let aPersonAssessmentItem:[IPersonAssesmentItem]?
    let aPersonAssessmentSkillItem:[IPersonAssesmentItem]?
    let bIsSetThanks:Bool?
    let bIsAnonymous:Bool?
   
    let sProjectId: String?
    let sRole:String?
    let lLastModifiedTime:Int64?
    let oProject:IOProject?
    let sRespondentComment:String?
    
}

struct IUserHistoryItem: Codable, Equatable, Hashable {
    let  sActivityType: String
    let  oPayload: IUserPayload
}

struct IUserHistoryRequest: Codable, Equatable, Hashable {
    let  sLoadOption: String
    let  bHasNext: Bool
    let oData:[IUserHistoryItem]
}



struct IUserHistoryListRequest: Codable, Equatable, Hashable {
    let  bHasNext: Bool
    let aObjects:[IUserHistoryList]
}



final class usersHistoryState: StateType, ObservableObject {
    @Published var historyList: [IUserHistoryList] = [initIUserHistoryList()]
    @Published var userHistory: [IUserHistoryItem] = []
    @Published var status = ""
    
}

final class usersHistoryStateS: StateType {
     var historyList: [IUserHistoryList] = [initIUserHistoryList()]
     var userHistory: [IUserHistoryItem] = []
     var status = ""
    
}

func initIUserHistoryList()-> IUserHistoryList{
    return IUserHistoryList(oRequester: initIUser())}


func usersHistoryReducer(action: Action, state: usersHistoryState?) -> usersHistoryState {
    let state = state ?? usersHistoryState()
    
    guard let action = action as? usersHistoryActions else {
        return state
    }
    
    switch action {
        
    case .successGetUserHistory(let data):
        state.userHistory = data
        state.status = "[Success] successGetUserHistory"
        break;
        
    case .successGetHistoryList(let data):
        state.historyList = data
        
        
        state.status = "[Success] successGetHistory"
        break;
        
    case .successUpdateAssessmentStatus:
        state.status = "[Success] successUpdateAssessmentStatus"
        break;
        
    case .successUpdateProjectAssessmentStatus:
        state.status = "[Success] successUpdateProjectAssessmentStatus"
        break;
    case .successSetHistoryUsersFilter:
        state.status = "[Success] successSetHistoryUsersFilter"
        break;
    case .setClearHistoryFlag:
        state.status = "[Set] setClearHistoryFlag"
        break;
    default:
        print("")
    }
    
    return state;
}
