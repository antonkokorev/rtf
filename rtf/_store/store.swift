//
//  store.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift
import Combine
import SwiftUI

/** реактивный store **/
public class ObservableState<T>: ObservableObject where T: StateType {

    // MARK: Public properties
    
    @Published public var state: T
    
    // MARK: Private properties
    
    private var store: Store<T>
    
    // MARK: Lifecycle
    
    public init(store: Store<T>) {
        self.store = store
        self.state = store.state
        
        store.subscribe(self)
    }
    
    deinit {
        store.unsubscribe(self)
    }
    
    // MARK: Public methods
    
    public func dispatch(_ action: Action) {
        store.dispatch(action)
    }
    
//    public func dispatch(_ action: Action) -> () -> Void {
//        {
//            self.store.dispatch(action)
//        }
//    }
}

extension ObservableState: StoreSubscriber {
    
    // MARK: - <StoreSubscriber>
    
    public func newState(state: T) {
        DispatchQueue.main.async {
            self.state = state
        }
    }
}


/** конфигурация стора, все файлы в state.swift **/
let mainStore = Store<AppState>(
    reducer: appReducer,
    state: nil,
	middleware: AppEffects
)

