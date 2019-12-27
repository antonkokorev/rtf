//
//  boss.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift


struct BossState: StateType {
    var collection = ""
    var status = "reactiveStoreTest"
}

func bossReducer(action: Action, state: BossState?) -> BossState {
    var state = state ?? BossState()

    guard let action = action as? bossActions else {
        return state
    }


    switch action {
    case .pendingGetBoss:
        state.status = "[Pending] pendingGetBoss"
        break;
    case .successGetBoss:
        state.collection = "data blob, state change"
        state.status = "[Success] successGetBoss"
        break;
    }
    
    return state;
}
