//
//  SwiftUIView.swift
//  rtf
//
//  Created by антон on 15.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

typealias TChart = [(name:String,value:Double,color:Color)]

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
    var values: TChart
    init(_ values: TChart) {
        self.values = values
    }
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
                ForEach(self.values, id:\.name) { item in
                    Button(action: {
                        self.clickChart(str: item.name + " " + String(format: "%.1f", item.value))
                    }){
                        VStack{
                            ZStack(alignment: .bottom){
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 20, height: 200)
                                    .foregroundColor(Color.RTFPallete.baseColor.blueGray)
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 20, height: CGFloat(20*item.value))
                                    .foregroundColor(item.color)
                            }
                            Text(String(format: "%.1f", item.value)).foregroundColor(Color.RTFPallete.textSecondary)
                        }
                    }}
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
    @State var value:Double = 0
    @State var text:String = ""
    let color:Color
    let clickChart:(_ str:String)-> Void
    var body: some View {
        
        Text("asdf")
        
        
    }
}

struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        Chart(
            [  (name:"Системное мышление и решение проблем",value:0, color:Color.red),
               ( name:"Управление результатом и ответсвенность",value:0, color:Color.red),
               (name:"Управление собой",value:0, color:Color.red),
               (name: "Инновационность и Digital навыки",value:0, color:Color.red),
               (name: "Клиентоцентричность",value:0, color:Color.red),
               (name:"Развитие команд и сотрудничество",value:6.0, color:Color.red)
        ])
    }
}
