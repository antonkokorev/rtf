//
//  HistoryAssessmentCard.swift
//  rtf
//
//  Created by 16688500 on 27.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct HistoryAssessmentCard: View {
    var item:IUserPayload
    var me:IUser
    var respondent:IUser
    
    
    init(item:IUserPayload,me:IUser,respondent:IUser){
        self.item = item
        self.me = me
        self.respondent = respondent
    }
    
    
    var status: String = "READ"
    var requester: String = "" //Отправитель
    //var respondent: String = "" //Получатель
    //=====================================================================================================================================
    func hwoIsOnPhoto() -> IUser{
     
        return  (item.sRespondentId == me.sUserId && (self.item.sStatus == "CREATED" || self.item.sStatus == "READ")) ||
            ( item.sRespondentId != me.sUserId &&  self.item.sStatus == "ANSWERED") ? self.me : self.respondent
    }
    
    //=====================================================================================================================================
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0){
            HStack{
                CircleImage(
                    imageUrl: getPhoto(hwoIsOnPhoto().sUserId ?? ""),
                    imageSize: BasicIconSizes.max
                )
                Text(hwoIsOnPhoto().sFirstName! + " " + hwoIsOnPhoto().sLastName!.prefix(1)+".")
                    .font(Font.Typography.sizingFont(font: .semibold, size: .H3))
                Spacer()
                Text( getData(date: (self.item.lLastModifiedTime == nil) ? self.item.lCreationTime! : self.item.lLastModifiedTime!  ,format: "dd MMM yyyy в HH:mm"))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .font(Font.Typography.sizingFont(font: .regular, size: .H4))
                    .foregroundColor(Color.RTFPallete.baseColor.white)
                    .background(RoundedCorners(color: Color.RTFPallete.baseColor.iconGray , tl: 20, tr: 20, bl: 20, br: 20))
            }.padding(.bottom, 15)
            
            if (item.sRespondentComment != "" && item.sRespondentComment != nil){
                Comment(expand: false, comment: item.sRespondentComment )
                    .padding(.horizontal, -30)
                    .padding(.bottom, 15)
            }
            
            VStack{
                HStack{
                    Text("Компетенции")
                        .font(Font.Typography.sizingFont(font: .regular, size: .H3))
                        .foregroundColor(Color.RTFPallete.textSecondary)
                        .padding(.leading, 15)
                        .padding(.top, 10)
                    Spacer()
                }
                
                VStack{
                    //Цикл с отбражением атрибутов
                    Attribute(number: 10, attribute: "Прорабатывает тему с заинтересованными сторонами")
                    Divider()
                    Attribute(attribute: "Глубоко понимает тему")
                    Divider()
                    Attribute(attribute: "Глубоко понимает тему")
                    
                    
                }.padding(.bottom, 15)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.RTFPallete.buttonGrayBackground, lineWidth: 1)
            ).padding(.bottom, 15)
            
            if (status == "READ"){
                Button(action: {
                    
                }) {
                    Text("Перейти к оценке")
                        .font(Font.Typography.sizingFont(font: .semibold, size: .H3))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                        .foregroundColor(Color.RTFPallete.buttonDefault)
                        .background(Color.RTFPallete.buttonGrayBackground)
                        .cornerRadius(10)
                }.padding(.bottom, 25)
            }
            
            ExDivider().padding(.horizontal, -30)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
        
    }
}

struct Attribute: View {
    var number: Int?
    var attribute: String = ""
    var body: some View{
        HStack(){
            ZStack{
                if (number != nil){
                    CircleImage(
                        imageSize: BasicIconSizes.max,
                        backgroundColor: Color.RTFPallete.baseColor.blueGray)
                    Text(String(number!))
                        .font(Font.Typography.sizingFont(font: .semibold, size: .H3))
                        .foregroundColor(Color.RTFPallete.buttonDefault)
                }else{
                    CircleImage(
                        //imageSize: BasicIconSizes.max,
                        icon: "attributeIcon",
                        iconSize: 40,
                        backgroundColor: Color.RTFPallete.baseColor.iconGray)
                }
                
            }.padding(.trailing, 20)
            
            Text(attribute)
                .lineLimit(5)
                .font(Font.Typography.sizingFont(font: .semibold, size: .H3))
                .foregroundColor(Color.RTFPallete.textDefault)
                .fixedSize(horizontal: false, vertical: true)
                .frame(alignment: .leading)
            Spacer()
        }.padding(.leading, 15)
        
    }
}


struct ExDivider: View {
    let color: Color = Color.RTFPallete.buttonGrayBackground
    let width: CGFloat = 5
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

//struct HistoryAssessmentCard_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryAssessmentCard()
//    }
//}

