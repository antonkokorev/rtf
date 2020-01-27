//
//  debounce.swift
//  rtf
//
//  Created by антон on 27.01.2020.
//  Copyright © 2020 team. All rights reserved.
//
import Dispatch

typealias Debounce<T> = (_ : T) -> Void

func debounce<T>(interval: Int, queue: DispatchQueue, action: @escaping Debounce<T>) -> Debounce<T> {
    var lastFireTime = DispatchTime.now()
    let dispatchDelay = DispatchTimeInterval.milliseconds(interval)

    return { param in
        lastFireTime = DispatchTime.now()
        let dispatchTime: DispatchTime = DispatchTime.now() + dispatchDelay

        queue.asyncAfter(deadline: dispatchTime) {
            let when: DispatchTime = lastFireTime + dispatchDelay
            let now = DispatchTime.now()

            if now.rawValue >= when.rawValue {
                action(param)
            }
        }
    }
}
