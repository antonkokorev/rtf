//
//  SublineComp.swift
//  rtf
//
//  Created by антон on 20.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct SublineComp: View {
    var text:String = "Системное мышление и решение проблем"
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            CircleImage(
                imageSize: BasicIconSizes.max,
                labelText: "10",
                labelColor: Color.RTFPallete.baseColor.white,
                backgroundColor: Color.RTFPallete.baseColor.textGray)
            Text(self.text).lineLimit(3).font(Font.Typography.sizingFont(font: .semibold, size: .H3)).padding(.leading, 10).foregroundColor(Color.RTFPallete.baseColor.mainBlue)
            
            Spacer()}}
}

struct SublineComp_Previews: PreviewProvider {
    static var previews: some View {
        SublineComp()
    }
}
