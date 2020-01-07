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

protocol AppStateType {
    var state: AppState { get }
}

typealias ActionCreatorables = RequestActionCreatorable
typealias RequestActionCreator = (_ state: AppState,_ store: DispatchingStoreType) -> Action?
protocol RequestActionCreatorable {
    func dispatch(_ actionCreatorProvider: @escaping RequestActionCreator)
}

class ReactiveStore: StoreSubscriber, DispatchingStoreType {
    var state: AppState { return store.state }
    var statePublisher: AnyPublisher<AppState, Never> {
        return stateSubject.eraseToAnyPublisher()
    }
    
    private let store: Store<AppState>
    private lazy var stateSubject: CurrentValueSubject<AppState, Never> = .init(state)
    
    init(store: Store<AppState>) {
        self.store = store
        self.store.subscribe(self)
    }
    
    deinit {
        self.store.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        stateSubject.send(state)
    }
    
    func dispatch(_ action: Action) {
        if Thread.isMainThread {
            store.dispatch(action)
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.store.dispatch(action)
            }
        }
    }
}

/* глобальный store приложения */
final class GlobalStore: ReactiveStore, ActionCreatorables {
    
    override init(store: Store<AppState>) {
        super.init(store: store)
    }
    
    private func create( _ actionCreatorProvider: @escaping RequestActionCreator) -> Action? {
        return actionCreatorProvider(state, self)
    }
    
    func dispatch(_ actionCreatorProvider: @escaping RequestActionCreator) {
        guard let action = create(actionCreatorProvider) else { return }
        dispatch(action)
    }
}
