//
//  Carousel.swift
//  rtf
//
//  Created by 16688500 on 29.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import SwiftUI

struct Carousel: View {

    @Environment(\.presentationMode) var  presentationMode:Binding<PresentationMode>
    
    @State private var searchTerm: String = ""
    
    let test:(_ msg:String) -> Void
    /* reactiveState */
    @ObservedObject var state: UsersRecentState
    
    var body: some View {
        
        VStack(){
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    Spacer(minLength: 30)
                    ForEach(state.collection) { item in
                        Button(action: {self.test("±!!")}) {
                            CarouselUser(
                                firstName: item.sFirstName!,
                                lastName: item.sLastName!,
								imageUrl: getPhoto(item.sUserId),
                                borderColor: .green)
                            }.self.buttonStyle(PlainButtonStyle())
                        }.padding(.trailing, 25.0)
                }
            .frame(height: 87)
            }
        }
    }
    struct Carousel_Previews: PreviewProvider {
        static var previews: some View {
            Carousel(test: { (firstSelectorString) in
                print(firstSelectorString) //this prints FirstButtonString
            }, state: AppMain().store.state.usersRecentSubState)
        }
        
    }
    
}
