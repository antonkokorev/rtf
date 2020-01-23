//
//  Slider.swift
//  rtf
//
//  Created by 16688500 on 22.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct CustomSlider: View {
    @State var score = 0.0
    
    var body: some View{
        VStack{
            HStack{
                CircleImage(
                )
                Spacer()
            Slider(value: $score, in: 1...10, step: 1)
                .accentColor(.blue)
                Spacer()
                CircleImage(
                )
            }
            Text(String(format: "%.0f", (score)))

        }.padding(.horizontal, 30)
        }
    }



struct CustomSlider_Previews: PreviewProvider {
    static var previews: some View {
        CustomSlider()
    }
}
