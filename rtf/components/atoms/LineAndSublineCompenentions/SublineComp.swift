//
//  SublineComp.swift
//  rtf
//
//  Created by антон on 20.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI
//import UIKit
//
//extension HorizontalAlignment {
//    private enum MyAlignment: AlignmentID {
//        static func defaultValue(in context: ViewDimensions) -> Length {
//            context[.trailing]
//        }
//    }
//    static let myAlignmentGuide = HorizontalAlignment(MyAlignment.self)
//}

struct SublineComp: View {
    var data: [ICompetence]
    var clickFunc:(_ id:String, _ title:String) -> Void =   { (tmp, tmp1) in print("вы кликнули по \(tmp)") }
    var body: some View {
        VStack(){
            ForEach(data, id: \.self  ) { item in
                HStack(){
                    ZStack{
                        CircleImage(
                            imageSize: BasicIconSizes.max,
                            backgroundColor: Color.RTFPallete.baseColor.blueGray)
                        Text(String(format: "%.1f",item.fAverageGrade))
                            .font(Font.Typography.sizingFont(font: .semibold, size: .H3))
                            .foregroundColor(Color.RTFPallete.buttonDefault)
                    }.padding(.trailing, 20)

                    Text(item.sName)
                        .lineLimit(5)
                        .font(Font.Typography.sizingFont(font: .regular, size: .H3))
                        .foregroundColor(Color.RTFPallete.baseColor.mainBlue)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(alignment: .leading)
                    Spacer()
                    
                }
                .onTapGesture {
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
