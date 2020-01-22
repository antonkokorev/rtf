//
//  Comment.swift
//  rtf
//
//  Created by 16688500 on 22.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct Comment: View {
    
    @State var expand: Bool? = false
    var comment: String! = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec enim diam vulputate ut pharetra. Sed turpis tincidunt id aliquet risus feugiat in. Interdum velit laoreet id donec ultrices tincidunt arcu non.  Lorem END"
    
    func resizeComment () -> Int{
        if expand != true {
            return 2
        }else{
            return 99
        }
    }
    
    var body: some View{
        VStack{
            Button(action: {
                self.expand!.toggle()
            },
                   label: {
                    Text(self.comment)
                        .padding(.all, 20)
                        .lineLimit(resizeComment())
                        .font(Font.Typography.sizingFont(font: .regular, size: .H3))
                        .foregroundColor(Color.RTFPallete.textDefault)
                        .multilineTextAlignment(.leading)
                        .background(RoundedCorners(color: Color.RTFPallete.backgroundDefault , tl: 10, tr: 20, bl: 20, br: 20))
            })
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal, 30)
    }
}

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
        }
    }
}

struct Comment_Previews: PreviewProvider {
    static var previews: some View {
        Comment()
    }
}
