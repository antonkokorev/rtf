//
//  ProfileMenu.swift
//  rtf
//
//  Created by 16688500 on 29.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import SwiftUI

struct ProfileMenu: View {
    @State var firstName: String!
    @State var lastName: String!
    @State var imageUrl: String
    
    var body: some View {
        GeometryReader{_ in
            //Spacer()
            VStack(spacing: 18){
                HStack(spacing: 10) {
                    CircleImage(
                        imageUrl: "\(self.imageUrl)",
                        imageSize: 40,
                        backgroundColor: .gray
                    )
                    Text(self.firstName + " " + self.lastName.prefix(1)+".")
                        .font(Font.Typography.sizingFont(font: .semibold, size: .H2))
                        .frame(width: 200, height: 13, alignment: .leading)
                    // Spacer()
                }
                .padding([.top, .leading], 24.0)
                
                VStack(spacing: 10){
                    Button(action: {
                    }) {
                        HStack(alignment: .firstTextBaseline){
                            Text("Мой профиль")
                                .font(Font.Typography.sizingFont(font: .semibold, size: .H2))
                                .foregroundColor(Color.RTFPallete.textDefault)
                                .frame(height: 23, alignment: .leading)
                            Spacer()
                        }
                    }
                    
                    Button(action: {
                    }) {
                        HStack(alignment: .firstTextBaseline){
                            Text("Статистика")
                                .font(Font.Typography.sizingFont(font: .semibold, size: .H2))
                                .foregroundColor(Color.RTFPallete.textDefault)
                                .frame(height: 23, alignment: .leading)
                            Spacer()
                        }
                    }
                    
                    Button(action: {
                    }) {
                        HStack(alignment: .firstTextBaseline){
                            Text("История")
                                .font(Font.Typography.sizingFont(font: .semibold, size: .H2))
                                .foregroundColor(Color.RTFPallete.textDefault)
                                .frame(height: 23, alignment: .leading)
                            Spacer()
                        }
                    }
                }.padding([.leading, .bottom], 20.0)
            }
            .frame(width: 250)
            .padding()
            .background(Color.white)
            .cornerRadius(BasicRadius.mini)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
            //Spacer()
        }
        .background(Color.black.opacity(0.65)
        .edgesIgnoringSafeArea(.all)
            
        )
    }
}

struct ProfileMenu_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMenu(firstName:"Иван",
                    lastName: "Длиннофамильный",
                    imageUrl:"https://avatars.mds.yandex.net/get-pdb/1054037/bf8c96bf-9986-4c8a-940b-d49ce998f906/s1200"
        )
    }
}
