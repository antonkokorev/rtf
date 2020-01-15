//
//  StartPage.swift
//  rtf
//
//  Created by антон on 13.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI
import PartialSheet
func greetUser(msg:String) {
            print(msg)
        }
struct StartPage: View {
    
    /* reactiveState */
    @ObservedObject var state: UsersRecentState
    @ObservedObject var users: UsersState
    let store: GlobalStore
    
    /* инициализатор store + state перед рендером */
    init(store: GlobalStore) {
        self.store = store
        self.state = store.state.usersRecentSubState
        self.users = store.state.usersSubState
        
    }
    
    
    @State private var showFeedBackPage = false
    @State private var longer: Bool = false


    //background(Color.RTFPallete.backgroundDefault)
    var body: some View {

        VStack(){
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    /** Аватарка и лайк*/
            HStack{
                CircleImage(imageSize: 40, icon: "like")
                Spacer()
                CircleImage(imageSize: 40, icon: "like")
            }.padding(.bottom, 20)
            
            Text("Привет," + "\n" + "userName!")
                .font(Font.Typography.sizingFont(font: .bold, size: .H1))
                .padding(.bottom, 25)
            
            HStack(spacing: 15){
                
                Button(
                    action: {},
                    label: {Text("Входящие")
                }).font(Font.Typography.sizingFont(font: .semibold, size: .H3)).foregroundColor(Color.RTFPallete.textSecondary);
                Button(
                    action: {},
                    label: {Text("Запросы")
                }).font(Font.Typography.sizingFont(font: .semibold, size: .H3)).foregroundColor(Color.RTFPallete.textSecondary);
                Button(
                    action: {},
                    label: {Text("Недавние")
                }).font(Font.Typography.sizingFont(font: .semibold, size: .H3)).foregroundColor(Color.RTFPallete.textSecondary);
                Spacer()
            }.padding(.bottom, 10)
            
        
            Carousel(test:greetUser , state: store.state.usersRecentSubState)
                .padding(.bottom, 30).onAppear(perform: {
                          self.store.dispatch(usersRecentActions.pendingGetRecentUsers)
                      })
            
            ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 12){
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Командный отчет")
                    .padding(10)
                }.font(Font.Typography.sizingFont(font: .semibold, size: .H3)).foregroundColor(Color.RTFPallete.buttonDefault)
                    .background(Color.RTFPallete.buttonGrayBackground)
                .cornerRadius(BasicRadius.max)
                
                Button(action: {}) {
                Text("История")
                    .padding(10)
                }.font(Font.Typography.sizingFont(font: .semibold, size: .H3)).foregroundColor(Color.RTFPallete.buttonDefault)
                .background(Color.RTFPallete.buttonGrayBackground)
                .cornerRadius(BasicRadius.max)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Статиситка")
                    .padding(10)
                }.font(Font.Typography.sizingFont(font: .semibold, size: .H3)).foregroundColor(Color.RTFPallete.buttonDefault)
                .background(Color.RTFPallete.buttonGrayBackground)
                .cornerRadius(BasicRadius.max)
                    

                            Spacer()
                        }.padding(.bottom, 10)
                    }.padding(.bottom, 25)
                        .padding(.leading, -30)
                    
                    /** Меню с ссылками на приложения*/
                    VStack(spacing: 15){
                        ActionCard(
                            textTitle: "TextTitle1",
                            textBody: "TextBody1",
                            icon: "like"
                        )
                        ActionCard(
                            textTitle: "TextTitle1",
                            textBody: "TextBody1",
                            icon: "like"
                        )
                        ActionCard(
                            textTitle: "TextTitle1",
                            textBody: "TextBody1",
                            icon: "like"
                        )
                        ActionCard(
                            textTitle: "TextTitle1",
                            textBody: "TextBody1",
                            icon: "like"
                        )
                    }.padding(.bottom, 30)
                    
                    /** Сообщить об ошибке*/
                    HStack{
                        Button(
                            action: {self.showFeedBackPage = true },
                            label: {Text("Сообщить об ошибке")
                                .font(Font.Typography.sizingFont(font: .regular, size: .H3)).foregroundColor(Color.RTFPallete.textSecondary)
                        })
                        Spacer()
                    }
                    Spacer(minLength: 25)
                }.padding(.horizontal, 30)
            }
            .partialSheet(presented: $showFeedBackPage) {
                FeedBackPage(store: self.store)
            }.padding(.top, 50)
                .background(Color.RTFPallete.backgroundDefault)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage(store: AppMain().store)
    }
}
