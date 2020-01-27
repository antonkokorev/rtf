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
                Text("\(user.sLastName ?? "") \(user.sFirstName ?? "") \(user.sMiddleName ?? "")")
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
                Spacer()
                Button(action: {
                    //Запросить обратную связь
                    self.action("post")
                  
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
                
                Spacer(minLength: 25)
                
                Button(action: {
                    //Дать обратную связь
                       self.action("get")
                },
                       label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 142, height: 145, alignment: .center)
                                .foregroundColor(Color.RTFPallete.baseColor.blueGray)
                                .cornerRadius(BasicRadius.mini)
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
                Spacer()
            }.padding(.bottom, 30)
            
            Spacer(minLength: 20)
            
        }
            .padding(.horizontal, 30)
            .animation(.none)
    }
}

