//
//  Like.swift
//  rtf
//
//  Created by anton on 04.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct Like: View {
    
    @State var number: Int
    
    var body: some View {
        ZStack{
            CircleImage(
                imageSize: 40,
                icon: "like",
                iconSize: 20,
                shadowOn: true,
                backgroundColor: Color.RTFPallete.buttonBlank
            )
            CircleImage(
                imageSize: 20,
                labelText: "\(number)",
                labelColor: Color.RTFPallete.buttonBlank,
                backgroundColor: Color.RTFPallete.buttonDefault
            ).offset(x: 15, y: -15)
        }
    }
    
    struct Like_Previews: PreviewProvider {
        static var previews: some View {
            Like(number: 99)
        }
    }
}
