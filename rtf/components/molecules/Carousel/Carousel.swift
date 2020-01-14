//
//  UserCard.swift
//  rtf
//
//  Created by 16688500 on 29.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import SwiftUI

struct CarouselUser{
    var firstName, lastName, imageUrl: String
}


struct UserCard: View {
    var user: CarouselUser
    var body: some View {
        VStack{
            CircleImage(
                imageUrl: "",
                imageSize: 64,
                icon: "like",
                backgroundColor: .green
            )
            Text(user.firstName)
                .frame(width: 64, height: 14, alignment: .center)
            Text(user.lastName)
                .frame(width: 64, height: 14, alignment: .center)
        }.frame(width: 80, height: 100, alignment: .center)
    }
}

struct UserCard_Previews: PreviewProvider {
    static var previews: some View {
        UserCard(
            imageUrl: "like",
            firstName: "String1",
            lastName: "String2"
        )
        )
    }
}
