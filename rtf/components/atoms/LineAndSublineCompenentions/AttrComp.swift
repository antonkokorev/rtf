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
                HStack(alignment: .center, spacing: 0){
                            CircleImage(
                                imageUrl: getPhoto(item.oUser.sUserId ?? "" ),
                        imageSize: BasicIconSizes.max
                    ).padding(.trailing, 10)
                    Text(item.oUser.sFullName ?? "").lineLimit(3).font(Font.Typography.sizingFont(font: .regular, size: .H3)).foregroundColor(Color.RTFPallete.textDefault)
                    Spacer()
                    CircleImage(
                                           imageSize: BasicIconSizes.max,
                                           labelText: String(format: "%.0f",item.iGrade),
                                           labelColor: Color.RTFPallete.baseColor.mainBlue,
                                           backgroundColor: Color.RTFPallete.baseColor.blueGray).padding(.trailing, 10)
                    
                }.padding()
                }
            }
        }
    }


struct AttrComp_Previews: PreviewProvider {
    static var previews: some View {
        SublineComp(data: [initICompetence()])
    }
}
