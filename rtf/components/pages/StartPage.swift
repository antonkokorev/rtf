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
    @ObservedObject var recentUsers: UsersRecentState
    @ObservedObject var requestUsers: usersRequestState
    @ObservedObject var users: UsersState
    @ObservedObject var favUsers: usersFavouriteState
    @ObservedObject var thanks: thanksState
    
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
        self.recentUsers = store.state.usersRecentSubState
        self.requestUsers = store.state.usersRequestSubState
        self.users = store.state.usersSubState
        self.favUsers = store.state.usersFavouriteSubState
        self.thanks = store.state.thanksSubState
    }
    
    
    @State private var showFeedBackPage = false
    @State private var longer: Bool = false
    
    
    var body: some View {
        VStack(){
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    /** Аватарка и лайк*/
                    Spacer(minLength: 5)
                    AvaLikeRow(userId: ((users.me.sUserId != "") ?  users.me.sUserId : "123"),
                               like: thanks.collection
                    )
                        .padding(.bottom, 20)
                    
                    /** Привет userName*/
                    HStack{
                        Text("Привет,\n\(users.me.sFirstName!)")
                            .font(Font.Typography.sizingFont(font: .bold, size: .H1))
                        Spacer()
                    }
                    .padding(.bottom, 25)
                    
                    /** Меню выбора списка юзеров*/
                    HStack{
                        RecentMenu()
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    
                    /** Карусель с юзерами*/
                    Carousel(test:greetUser , state: recentUsers)
                        .padding(.bottom, 30)
                        .padding(.horizontal, -30)
                    
                    /** Меню с кнопками Отчет-История-Статистика*/
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            Spacer(minLength: 30)
                            HistoryStatsMenu()
                            Spacer()
                        }
                        .padding(.bottom, 10)
                    }
                    .padding(.bottom, 25)
                    .padding(.horizontal, -30)
                    
                    /** Меню с ссылками на приложения*/
                    VStack(spacing: 15){
                        ActionCard(
                            action: self.goNextPage,
                            textTitle: "Коллеги",
                            textBody: "Обратная связь по компетенциям и проф. навыкам",
                            icon: "home__feedback"
                        ).sheet(isPresented: $usersModal) {

//							FeedBackPage(store: self.store)

                            HistoryPage(store:  self.store)

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
        .padding(.top, 10)//Для обхода SafeArea
        .onAppear(perform: {
            self.store.dispatch(usersActions.pendingGetMe)
            self.store.dispatch(thanksActions.pendingGetThanksCount)
            self.store.dispatch(usersFavouriteActions.pendingGetFavFeedbackUsers)
            self.store.dispatch(usersRecentActions.pendingGetRecentUsers)
            self.store.dispatch(usersRecentActions.pendingGetRecentUsers)
        })
    }
}


//*Аватар пользователя и кнопка с лайками*/
struct AvaLikeRow: View {
    @State var userId: String!
    @State var like: Int!
    
    var body: some View{
        HStack{
            CircleImage(
                imageUrl: getPhoto(userId),
                imageSize: BasicIconSizes.max
            )
            Spacer()
            Like(number: like ?? 88)
        }
    }
}


//-------------------------------------------------------------------------
//Меню Входящие-Запросы-Недвание
func RecentMenu()-> HorizontalMenu{
    return HorizontalMenu(
        texts: ["Входящие", "Запросы", "Недвание"],
        active: 0,
        activeFont: Font.Typography.sizingFont(font: .semibold, size: .H3),
        passiveFont: Font.Typography.sizingFont(font: .semibold, size: .H3),
        activeFontColor: Color.RTFPallete.textDefault,
        passiveFontColor: Color.RTFPallete.textSecondary,
        horizontalPadding: 0,
        verticalPadding: 10,
        buttonSpace: 10,
        cloud: false
    )
}
//-------------------------------------------------------------------------
//Меню перехода в Историю-Статистику-Командный отчет
func HistoryStatsMenu()-> HorizontalMenu{
    return HorizontalMenu(
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
}
//-------------------------------------------------------------------------
/**Превью*/
struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage(store: AppMain().store)
    }
}
