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
    @ObservedObject var favUsers: usersFavouriteState
    
    @State var usersModal:Bool = false
    @State var historyModal:Bool = false
    let store: GlobalStore
    /** функция обработка кнопок тайлов*/
    private  func goNextPage(page:String) -> Void {
        self.usersModal = true
        print(page,showFeedBackPage)
    }
    
    /** инициализатор store + state перед рендером */
    init(store: GlobalStore) {
        self.store = store
        self.state = store.state.usersRecentSubState
        self.users = store.state.usersSubState
        self.favUsers = store.state.usersFavouriteSubState
    }


    @State private var showFeedBackPage = false
    @State private var longer: Bool = false


    var body: some View {
        VStack(){
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    /** Аватарка и лайк*/
                    AvaLikeRow()
                        .padding(.bottom, 20)
                        .onAppear(perform: {
                            self.store.dispatch(usersActions.pendingGetMe)
                        })

                    /** Привет userName*/
                    HStack{
                        Text("Привет,\n\(users.me.sFirstName!)")
                            .font(Font.Typography.sizingFont(font: .bold, size: .H1))
                        Spacer()
                    }
                    .padding(.bottom, 25)

                    /** Меню выбора списка юзеров*/
                    HStack{
                        HorizontalMenu(
                            texts: ["Входящие", "Запросы", "Недвание"],
                            active: 0,
                            activeFont: Font.Typography.sizingFont(font: .semibold, size: .H3),
                            passiveFont: Font.Typography.sizingFont(font: .semibold, size: .H3),
                            activeFontColor: Color.RTFPallete.textDefault,
                            passiveFontColor: Color.RTFPallete.textSecondary,
                            horizontalPadding: 0,
                            verticalPadding: 10,
                            buttonSpace: 10,
                            cloud: false)
                        Spacer()
                    }
                    .padding(.bottom, 10)

                    /** Карусель с юзерами*/
                    Carousel(test:greetUser , state: store.state.usersRecentSubState)
                        .padding(.bottom, 30)
                        .padding(.horizontal, -30)
                        .onAppear(perform: {
                            self.store.dispatch(usersRecentActions.pendingGetRecentUsers)
                        })

                    /** Меню с кнопками Отчет-История-Статистика*/
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            Spacer(minLength: 30)
                            HorizontalMenu(
                                texts: ["История", "Статистика"],
                                active: 99,
                                activeFont: Font.Typography.sizingFont(font: .semibold, size: .H3),
                                passiveFont: Font.Typography.sizingFont(font: .semibold, size: .H3),
                                activeFontColor: Color.RTFPallete.buttonDefaultPale,
                                passiveFontColor: Color.RTFPallete.buttonDefaultPale,
                                activeColor: Color.RTFPallete.buttonGrayBackground,
                                passiveColor: Color.RTFPallete.buttonGrayBackground,
                                activeBorderColor: Color.RTFPallete.buttonGrayBackground,
                                passiveBorderColor: Color.RTFPallete.buttonGrayBackground,
                                horizontalPadding: 10,
                                verticalPadding: 10,
                                buttonSpace: 10,
                                cloud: true
                            )
                            Spacer()
                        }
                        .padding(.bottom, 10)
                    }
                    .padding(.bottom, 25)
                    .padding(.horizontal, -30)
ActionCardList()
                    /** Меню с ссылками на приложения*/
                    VStack(spacing: 15){
                        ActionCard(
                            action: self.goNextPage,
                            textTitle: "Коллеги",
                            textBody: "Обратная связь по компетенциям и проф. навыкам",
                            icon: "home__feedback"
                        ).sheet(isPresented: $usersModal) {
                            FavouriteUsersGrid(users: self.favUsers.collection)
                                .padding(.top ,35)
                            // HistoryPage(store:  self.store)
                        }
                        ActionCard(
                            action: self.goNextPage,
                            textTitle: "Встречи",
                            textBody: "Обратная связь по компетенциям на встречах",
                            icon: "home__meetings"
                        )
                        ActionCard(
                            action: self.goNextPage,
                            textTitle: "Достижения",
                            textBody: "Обратная связь по достижениям и проектам",
                            icon: "home__projects"
                        )
                        ActionCard(
                            action: self.goNextPage,
                            textTitle: "Профоценка SberProfi",
                            textBody: "Оценка уровня профессионального мастерства",
                            icon: "home__sberprofi"
                        )
                    }
                    .padding(.bottom, 30)

                    /** Сообщить об ошибке*/
                    HStack{
                        Button(
                            action: {self.showFeedBackPage = true },
                            label: {Text("Сообщить об ошибке")
                                .font(Font.Typography.sizingFont(font: .regular, size: .H3)).foregroundColor(Color.RTFPallete.textSecondary)
                        })
                        Spacer()
                    }

                    /**Минимальный отступ от нижнего края экрана*/
                    Spacer(minLength: 25)
                }
                .padding(.horizontal, 30)
            }
        }
        .onAppear(perform: {
            self.store.dispatch(usersActions.pendingGetMe)
            self.store.dispatch(usersFavouriteActions.pendingGetFavFeedbackUsers)
        })
    }
}


//*Аватар пользователя и кнопка с лайками*/
struct AvaLikeRow: View {
    var body: some View{
        HStack{
            CircleImage(imageUrl: getPhoto("Admin_LB"), imageSize: BasicIconSizes.max)
            Spacer()
            CircleImage(imageSize: BasicIconSizes.max, icon: "like")
        }
    }
}

/**Превью*/
struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage(store: AppMain().store)
    }
}
