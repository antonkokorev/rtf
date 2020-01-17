//
//  ActionCard.swift
//  rtf
//
//  Created by anton on 09.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct ActionCardList: View {
    
    struct Card {
        let action: (String) -> Void
        let textTitle: String
        let textBody: String
        let icon: String
    }
    
    let Cards = [
        Card(action: {_ in print("asdf")}, textTitle: "asdf", textBody: "asdf", icon: "like"),
        Card(action: {_ in print("asdf")}, textTitle: "asdf", textBody: "asdf", icon: "like"),
        Card(action: {_ in print("asdf")}, textTitle: "asdf", textBody: "asdf", icon: "like"),
        Card(action: {_ in print("asdf")}, textTitle: "asdf", textBody: "asdf", icon: "like"),
    ]
    
    var body: some View {

            ActionCard(
                action: self.Cards[0].action,
                textTitle: self.Cards[0].textTitle,
                textBody: self.Cards[0].textBody,
                icon: self.Cards[0].icon)
        
    }
}


struct ActionCardList_Previews: PreviewProvider {
    static var previews: some View {
        ActionCardList()
    }
}
