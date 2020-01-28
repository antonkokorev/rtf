//
//  HistoryAssessmentCard.swift
//  rtf
//
//  Created by 16688500 on 27.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct HistoryAssessmentCard: View {
    
    var imageUrl: String = ""
    var firstName: String = "Имя"
    var lastName: String = "Фамилия"
    var date: String = "20.20.2020 в 20:20"
    var comment: String? = "Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий Комментарий "
    
    
    var body: some View {
        
        VStack{
            HStack{
                CircleImage(
                    imageSize: 40
                )
                Text(firstName + " " + lastName.prefix(1)+".")
                    .font(Font.Typography.sizingFont(font: .semibold, size: .H3))
                Spacer()
                Text(date)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .font(Font.Typography.sizingFont(font: .regular, size: .H4))
                    .foregroundColor(Color.RTFPallete.baseColor.white)
                    .background(RoundedCorners(color: Color.RTFPallete.baseColor.iconGray , tl: 20, tr: 20, bl: 20, br: 20))
            }.padding(.bottom, 15)
            
            if (comment != ""){
                Comment(expand: false, comment: comment)
                .padding(.horizontal, -30)
                .padding(.bottom, 15)
            }
            
            VStack{
                Text("\(comment!)").padding(.all, 15)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.RTFPallete.buttonGrayBackground, lineWidth: 1)
            )
            
            
            
            
            
            
            
            
        ExDivider().padding(.horizontal, -30)
        }
        .padding(.horizontal, 30)
        
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

struct HistoryAssessmentCard_Previews: PreviewProvider {
    static var previews: some View {
        HistoryAssessmentCard()
    }
}

