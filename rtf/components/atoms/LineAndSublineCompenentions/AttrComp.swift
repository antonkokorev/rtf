//
//  SublineComp.swift
//  rtf
//
//  Created by антон on 20.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct AttrComp: View {
    var data: [IAttr]
    var clickFunc:(_ id:String, _ title:String) -> Void =   { (tmp, tmp1) in print("вы кликнули по \(tmp)") }
    var body: some View {
        
        List{
            ForEach(data, id: \.self  ) { item in
                VStack{
                    HStack{
                        CircleImage(
                            imageUrl: getPhoto(item.oUser.sUserId ?? "" ),
                            imageSize: 50
                        )
                            .padding(.trailing, 15)
                        
                        VStack(alignment: .leading){
                            Text((item.oUser.sFirstName ?? "") + " " + (item.oUser.sLastName ?? ""))
                                .lineLimit(3)
                                .font(Font.Typography.sizingFont(font: .semibold, size: .H2))
                                .foregroundColor(Color.RTFPallete.textDefault)
                            Text(item.oUser.sTitle ?? "")
                                .lineLimit(1)
                                .font(Font.Typography.sizingFont(font: .regular, size: .H3))
                                .foregroundColor(Color.RTFPallete.textSecondary)
                        }
                        
                        Spacer()
                        
                        ZStack{
                            CircleImage(
                                imageSize: BasicIconSizes.max,
                                labelColor: Color.RTFPallete.baseColor.mainBlue,
                                backgroundColor: Color.RTFPallete.baseColor.blueGray
                            )
                            Text(String(format: "%.0f",item.iGrade))
                                .font(Font.Typography.sizingFont(font: .semibold, size: .H3))
                                .foregroundColor(Color.RTFPallete.buttonDefault)
                        }
                    }
                    
                    Text(item.sComment)
                        .font(Font.Typography.sizingFont(font: .regular, size: .H3))
                        .foregroundColor(Color.RTFPallete.textSecondary)
                    
                    Divider()
                }.padding(.bottom, 15)
            }
        }.padding(.horizontal, 15)
    }
}


//struct AttrComp_Previews: PreviewProvider {
//    static var previews: some View {
//        SublineComp(data: [initICompetence()])
//    }
//}
