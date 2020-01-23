//
//  SublineComp.swift
//  rtf
//
//  Created by антон on 20.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct SublineComp: View {
    var data: [ICompetence]
    var clickFunc:(_ id:String, _ title:String) -> Void =   { (tmp, tmp1) in print("вы кликнули по \(tmp)") }
    var body: some View {
        VStack{
            ForEach(data, id: \.self  ) { item in
                HStack(alignment: .center, spacing: 0){
                    CircleImage(
                        imageSize: BasicIconSizes.max,
                        labelText: String(format: "%.1f",item.fAverageGrade),
                        labelColor: Color.RTFPallete.baseColor.mainBlue,
                        backgroundColor: Color.RTFPallete.baseColor.blueGray).padding(.trailing, 10)
                    Text(item.sName).lineLimit(3).font(Font.Typography.sizingFont(font: .regular, size: .H4)).foregroundColor(Color.RTFPallete.baseColor.mainBlue)
                    Spacer()}.onTapGesture {
                        if(item.fAverageGrade != 0){
                            self.clickFunc(item.sId, item.sName)
                        }
                }
            }
        }
    }
}

struct SublineComp_Previews: PreviewProvider {
    static var previews: some View {
        SublineComp(data: [initICompetence()])
    }
}
