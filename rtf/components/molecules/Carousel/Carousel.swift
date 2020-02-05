//
//  Carousel.swift
//  rtf
//
//  Created by 16688500 on 29.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import SwiftUI

struct Carousel: View {
    var action: (_ msg:IUser) -> Void = {i in print(i)}
    var users: [IUser]
    
    init(_ users: [IUser] ){
        self.users = users
    }
    init(_ users: [IUser] , action:@escaping (_ msg:IUser) -> Void ){
          self.users = users
        self.action = action

        
      }
    var body: some View {
        
        VStack(){
            if (self.users.count != 0){
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        Spacer(minLength: 30)
                        ForEach(self.users) { item in
                            
                          //  Button(action: {
                          //      self.action(item)
                           // }) {
                                CarouselUser(
                                    firstName: item.sFirstName!,
                                    lastName: item.sLastName!,
                                    imageUrl: getPhoto(item.sUserId!)
                                    //borderColor: .green
                                ).onTapGesture {
                                  self.action(item)
                            }
                 //}.self.buttonStyle(PlainButtonStyle())
                    
                            
                            
                }.padding(.trailing, 25.0)
                    }
                    .frame(height: 87)
                }
            }else{
                ZStack{
                    Rectangle()
                        .frame(height: 87, alignment: .center)
                        .foregroundColor(Color.RTFPallete.carouselBackground)
                        .cornerRadius(BasicRadius.micro)
                    HStack{
                        Spacer(minLength: 20)
                        Text("Новых\nуведомлений\nнет")
                            .font(Font.Typography.sizingFont(font: .semibold, size: .H3))
                            .frame(width: 100, height: 60)
                            .foregroundColor(Color.RTFPallete.textSecondary)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Image("carousel_img")
                        Spacer(minLength: 20)
                    }
                }.padding(.horizontal, 30)
            }
            }
    }
    //    struct Carousel_Previews: PreviewProvider {
    //        static var previews: some View {
    //            Carousel(test: { (firstSelectorString) in
    //                print(firstSelectorString) //this prints FirstButtonString
    //            }, state: AppMain().store.state.usersRecentSubState)
    //        }
    //
    //    }
    
}
