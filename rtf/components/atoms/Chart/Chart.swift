//
//  SwiftUIView.swift
//  rtf
//
//  Created by антон on 15.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

class TimerHolder  {
    var timer : Timer!
    var action:()->Void = {}
    func start(action:@escaping ()->Void ) {
        self.action = action
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) {
            _ in
            self.action()
            
        }
    }
}
struct Chart: View {
    let values:[Double]
    let texts:[String]=[
        "Системное мышление и решение проблем",
        "Управление результатом и ответсвенность",
        "Управление собой",
        "Инновационность и Digital навыки",
        "Клиентоцентричность",
        "Развитие команд и сотрудничество"
    ]
    let colors:[Color]=[]
    
    @State var showPopover : Bool = false
    @State var textPopover : String = ""
    var timer : TimerHolder = TimerHolder()
    
    private func clickChart(str:String){
        self.textPopover = str
        self.showPopover = true
        timer.start(action:{self.showPopover = false})
    }
    
    
    var body: some View {
        ZStack{
            HStack( alignment: .center, spacing: 35){
                
                ForEach((0...5), id: \.self) {
                    ChartItem(
                        value: self.values[$0],
                        text: self.texts[$0],
                        color:Color("chart\($0)"),
                        clickChart:self.clickChart)
                }
            }.animation(.default)
            if(showPopover == true){
                Button(action: {
                    self.showPopover = false
                }){
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                        
                        Text("\(textPopover)")
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .frame(width: 280, height: 50)
                    }.frame(width: 300, height: 50).opacity(0.7).accentColor(Color.black).animation(.easeIn(duration: 0.3))
                }
                
                
            }}
    }
}




struct ChartItem: View {
    let value:Double
    let text:String
    let color:Color
    let clickChart:(_ str:String)-> Void
    var body: some View {
        Button(action: {
            self.clickChart(self.text + " " + String(format: "%.1f", self.value))
        }) {
            VStack{
                ZStack(alignment: .bottom){
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 25, height: 200)
                        .foregroundColor(Color.RTFPallete.baseColor.blueGray)
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 25, height: CGFloat(20*value))
                        .foregroundColor(color)
                }
                Text(String(format: "%.1f", value)).foregroundColor(Color.RTFPallete.textSecondary)
            }
        }}
}

struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        Chart(values: [10,1,6,7,8,4])
    }
}
