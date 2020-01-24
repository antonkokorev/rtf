//
//  UserFeedbackPopup.swift
//  rtf
//
//  Created by 16688500 on 21.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import Foundation
import SwiftUI
import URLImage

struct UserFeedbackPopup: View {

    @State var fullName: String = ""
    @State var imageUrl: String = ""
    @State var position: String = ""
    var user:IUser = initIUser()
    var action:(_ method:String) -> Void = {i in print(i)}
    var body: some View {
        VStack{
            
            Spacer(minLength: 20)
            //ФИО и должность
            VStack{
                if (self.user.sUserId  != nil && self.user.sUserId  != "") {
                CircleImage(
                    imageUrl: getPhoto(self.user.sUserId ??  ""),
                    imageSize: 90
                ).padding(.bottom, 15.0)
                }
                Text(user.sFullName ?? "")

                    .font(Font.Typography.sizingFont(font: .bold, size: .H2))
                    .foregroundColor(Color.RTFPallete.textDefault)
                    .padding(.bottom, 4.0)
                Text(user.sTitle ?? "")
                    .font(Font.Typography.sizingFont(font: .regular, size: .H3))
                    .foregroundColor(Color.RTFPallete.textSecondary)
                    .multilineTextAlignment(.center).frame(height: 42.0)
            }.padding(.bottom, 30)
            
            //Кнопки дать-взять обратную связь
            HStack{
                Button(action: {
                    //Запросить обратную связь
                    self.action("post")
                    print(self.user)
                },
                       label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 142, height: 145, alignment: .center)
                                .foregroundColor(Color.RTFPallete.litePink)
                                .cornerRadius(BasicRadius.micro)
                            VStack{
                                CircleImage(
                                    imageSize: 60,
                                    icon: "arrow_down_white",
                                    iconSize: 35,
                                    backgroundColor: Color.RTFPallete.baseColor.mainPink)
                                Text("Дать \n обратную связь")
                                    .font(Font.Typography.sizingFont(font: .semibold, size: .H4))
                                    .foregroundColor(Color.RTFPallete.textDefault)
                                    .multilineTextAlignment(.center).frame(height: 42.0)
                            }
                        }
                }).buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                Button(action: {
                    //Дать обратную связь
                       self.action("get")
                },
                       label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 142, height: 145, alignment: .center)
                                .foregroundColor(Color.RTFPallete.baseColor.blueGray)
                                .cornerRadius(BasicRadius.micro)
                            VStack{
                                CircleImage(
                                    imageSize: 60,
                                    icon: "arrow_up_white",
                                    iconSize: 35,
                                    backgroundColor: Color.RTFPallete.baseColor.mainBlue)
                                Text("Оставить \n обратную связь")
                                    .font(Font.Typography.sizingFont(font: .semibold, size: .H4))
                                    .foregroundColor(Color.RTFPallete.textDefault)
                                    .multilineTextAlignment(.center).frame(height: 42.0)
                            }
                        }
                }).buttonStyle(PlainButtonStyle())
            }.padding(.bottom, 30)
            
            //Футер
            Button(action:{
                //Переход в историю пользователя
            } ,
                   label: {
                    Text("История оценок")
                        .font(Font.Typography.sizingFont(font: .semibold, size: .H3))
                        .foregroundColor(Color.RTFPallete.buttonDefault)
            }).buttonStyle(PlainButtonStyle())
            
            Spacer(minLength: 20)
            
        }.frame(height: 460, alignment: .center)
            .padding(.horizontal, 30)
        //.background(Color.red)
    }
}

//struct UserFeedbackPopup_Previews: PreviewProvider {
//    static var previews: some View {
//        UserFeedbackPopup(
//			firstName: "Иван",
//			lastName: "Петров",
//			middleName: "Анатольевич",
//            imageUrl:"https://avatars.mds.yandex.net/get-pdb/1054037/bf8c96bf-9986-4c8a-940b-d49ce998f906/s1200", position: "Управляющий директор - начальник управления")
//    }
//}
