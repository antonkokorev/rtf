//
// Created by anton on 30/12/2019.
// Copyright (c) 2019 Anton Kokorev. All rights reserved.
//

import Combine
import Foundation

class UserViewModel: ObservableObject {
    //input
    @Published var username = ""
    @Published var password = ""
    @Published var passwordAgain = ""
    //output
    @Published var isValid = false
    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        $username
                .debounce(for: 0.8, scheduler: RunLoop.main)
                .removeDuplicates()
                .map { input in
                    return input.count >= 3
                }
                .assign(to: \.isValid, on: self)
                .store(in: &cancellableSet)
    }
}
