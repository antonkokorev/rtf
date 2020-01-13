//
//  FeedBackPage.swift
//  rtf
//
//  Created by антон on 13.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct FeedBackPage: View {
    @Environment(\.presentationMode) var  presentationMode:Binding<PresentationMode>
    var body: some View {
        VStack{
          Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("close")
                
            })
        }
        
    }
}

struct FeedBackPage_Previews: PreviewProvider {
    static var previews: some View {
        FeedBackPage()
    }
}
