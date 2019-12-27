//
//  message.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift


struct MessageState: StateType {
    var collection = ""
    var status = ""
}

func messageReducer(action: Action, state: MessageState?) -> MessageState {
    var state = state ?? MessageState()

    guard let action = action as? messageActions else {
        return state
    }

    switch action {
    case .successShowMessage:
        state.collection = "data blob, state change"
        state.status = "[Success] successShowMessage"
        break;
    }
    
    return state;
}
