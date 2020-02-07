//
//  CompetencyRequestPopup.swift
//  rtf
//
//  Created by Anton Elistratov on 29.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct CompetencyRequestPopup: View {
    @EnvironmentObject var obj: MTFHeight
    @State var test: String = ""
    @Binding var total: Int
    
    var body: some View {
        VStack {
            HStack{
                Text("Выбрано: ")
                    .font(Font.Typography.sizingFont(font: .semibold, size: .H2))
                    .foregroundColor(Color.RTFPallete.textDefault)
                ZStack{
                    CircleImage(
                        imageSize: 35,
                        backgroundColor: Color.RTFPallete.buttonDefault
                    )
                    Text("\(self.total)")}
                    .font(Font.Typography.sizingFont(font: .bold, size: .H2))
                    .foregroundColor(Color.RTFPallete.baseColor.white)
                Spacer()
            }
            //Spacer()
            HStack(alignment: .bottom) {
                MultiTextField()//"Добавить комментарий", text: $test)
                    .frame(width: UIScreen.main.bounds.width * 0.6, height: (obj.size < 150) ? obj.size : 150)
                    .background(Color.RTFPallete.baseColor.white)
                    .cornerRadius(20)
                
                Spacer()
                Button(action: {
                    
                }, label: {
                    ZStack{
                        CircleImage(
                            imageSize: 60,
                            backgroundColor: Color.RTFPallete.buttonDefault
                        )
                        Image("arrow_down_white")
                            .rotationEffect(.degrees(-90))
                            .foregroundColor(Color.RTFPallete.baseColor.white)
                    }
                })
            }
            //Spacer()
        }.padding(.horizontal, 30)
    }
}

struct MultiTextField: UIViewRepresentable {
    @EnvironmentObject var obj: MTFHeight
    
    func makeCoordinator() -> MultiTextField.Coordinator {
        return MultiTextField.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MultiTextField>) -> UITextView {
        let view = UITextView()
        view.font = .systemFont(ofSize: 16)
        view.text = "Добавить комментарий"
        view.textColor = UIColor.black.withAlphaComponent(0.4)
        view.backgroundColor = .clear
        
        view.delegate = context.coordinator
        self.obj.size = view.contentSize.height
        
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true
        
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiTextField>) {
        
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent = MultiTextField()
        init(parent1: MultiTextField){
            parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = UIColor.black
            
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.obj.size = textView.contentSize.height
        }
    }
}

class MTFHeight: ObservableObject{
    @Published var size: CGFloat = 45
}
