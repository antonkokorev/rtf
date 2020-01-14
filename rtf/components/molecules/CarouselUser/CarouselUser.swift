//
//  CarouselUser.swift
//  rtf
//
//  Created by 16688500 on 29.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import SwiftUI

struct CarouselUser: View {
    @State var firstName: String!
    @State var lastName: String!
    @State var imageUrl: String
    @State var borderColor: Color?
    
    var body: some View {
        VStack{
            CircleImage(
                imageUrl: "\(imageUrl)",
                imageSize: 60,
                borderColor: borderColor,
                backgroundColor: .gray
            )
            Text(firstName + " " + lastName.prefix(1)+".")
                .font(Font.Typography.sizingFont(font: .semibold, size: .H4))
                .frame(width: 60, height: 13, alignment: .center)
        }.frame(width: 72, height: 96, alignment: .center)
    }
}

struct CarouselUser_Previews: PreviewProvider {
    static var previews: some View {
        CarouselUser(firstName:"Иван",
                     lastName: "Длиннофамильный",
                     imageUrl:"https://avatars.mds.yandex.net/get-pdb/1054037/bf8c96bf-9986-4c8a-940b-d49ce998f906/s1200",
                     borderColor: .blue)
    }
}
