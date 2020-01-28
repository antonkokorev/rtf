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
	@ObservedObject var error: ErrorState

    /**Модальные окна*/
	@State var feedbackModal:Bool = false
	@State var historyModal:Bool = false

    @State var statisticsModal:Bool = false

    /** функция обработка кнопок тайлов*/
    private  func goNextPage(page:String) -> Void {
        switch page {
        case "История":
            historyModal = true
           self.store.dispatch(usersHistoryActions.pendingGetHistoryList)
           self.store.dispatch(usersHistoryActions.pendingGetUserHistory("ALL","matvey"))
        case "Статистика":
            statisticsModal = true
        case "home__feedback":
            self.store.dispatch(usersFavouriteActions.pendingGetFavFeedbackUsers)
            feedbackModal = true
        default:
            break
        }
    }

	/** индикатор для выбора пункта меню **/
	@State var activeCarousel: Int = 0
	
	/** индикатор для выбора пункта меню **/
	@State var activeBinaryMenu: Int = 0

	let store: GlobalStore


	/** инициализатор store + state перед рендером */
	init(store: GlobalStore) {
		self.store = store
		self.recentUsers = store.state.usersRecentSubState
		self.requestUsers = store.state.usersRequestSubState
		self.users = store.state.usersSubState
		self.favUsers = store.state.usersFavouriteSubState
		self.thanks = store.state.thanksSubState
		self.error = store.state.errorSubState
	}

	@State private var showFeedBackPage = false
	@State private var longer: Bool = false

	/** Возвращает массив с пользователями в зависимости от вкладки  **/
	func stateSelector(_ tab: Int) -> [IUser] {
		switch tab {
			/** Входящие  **/
		case 0:
			return self.recentUsers.collection
			/** Избранные  **/
		case 1:
			/** фильтр кнопки ADD **/
			var filtred: [IUser] = []

			for user in self.favUsers.collection {
				if (user.bAddButton != true) {
					filtred.append(user)
				}
			}
			return filtred
			/** Недавние  **/
		case 2:
			return self.recentUsers.collection
			/** пустота **/
		default:
			return []
		}
	}


	var body: some View {
		VStack(){
			ScrollView(.vertical, showsIndicators: false){
				VStack(spacing: 0){
					/** Аватарка и лайк **/
					Spacer(minLength: 5)

					if (users.me.sUserId != nil && users.me.sUserId != "") {
						AvaLikeRow(userId: ((users.me.sUserId != "") ?  users.me.sUserId : "123"),
								   like: thanks.collection
						)
							.padding(.bottom, 20)
					}

					/** Привет userName **/
					HStack{
						Text("Привет,\n\(users.me.sFirstName!)")
							.font(Font.Typography.sizingFont(font: .bold, size: .H1))
						Spacer()
					}
					.padding(.bottom, 25)

					/** Меню выбора списка юзеров **/
					HStack{
						HorizontalMenu(
							texts: ["Оценки", "Запросы", "Недвание"],
							active: self.$activeCarousel,
							activeFont: Font.Typography.sizingFont(font: .semibold, size: .H3),
							passiveFont: Font.Typography.sizingFont(font: .semibold, size: .H3),
							activeFontColor: Color.RTFPallete.textDefault,
							passiveFontColor: Color.RTFPallete.textSecondary,
							horizontalPadding: 0,
							verticalPadding: 0,
							buttonSpace: 10,
							cloud: false
						)
						Spacer()
					}
					.padding(.bottom, 10)

					/** Карусель с юзерами*/
					Carousel(stateSelector(self.activeCarousel))
						.padding(.bottom, 30)
						.padding(.horizontal, -30)

					/** Меню с кнопками Отчет-История-Статистика*/
					ScrollView(.horizontal, showsIndicators: false){
						HStack{
							Spacer(minLength: 30)
							HorizontalMenu(
								texts: ["История", "Статистика"],
								active: self.$activeBinaryMenu,
								activeFont: Font.Typography.sizingFont(font: .semibold, size: .H3),
								passiveFont: Font.Typography.sizingFont(font: .semibold, size: .H3),
								activeFontColor: Color.RTFPallete.buttonDefaultPale,
								passiveFontColor: Color.RTFPallete.buttonDefaultPale,
								activeColor: Color.RTFPallete.buttonGrayBackground,
								passiveColor: Color.RTFPallete.buttonGrayBackground,
								activeBorderColor: Color.RTFPallete.buttonGrayBackground,
								passiveBorderColor: Color.RTFPallete.buttonGrayBackground,
								horizontalPadding: 15,
								verticalPadding: 10,
								buttonSpace: 10,
                                clickFunc: goNextPage,
								cloud: true
                            )
                            Spacer()
                            .sheet(isPresented: $historyModal) {
                                FeedBackPage(store: self.store)
                            }
                            Spacer()
                            .sheet(isPresented: $statisticsModal) {
                                StatisticsPage(store: self.store)
                            }

							Spacer()
						}
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

						).sheet(isPresented: $feedbackModal) {
                            
							FeedBackPage(store: self.store)
                        }
						ActionCard(
							action: self.goNextPage,
							textTitle: "Встречи",
							textBody: "Обратная связь по компетенциям на встречах",
							icon: "home__meetings"
						).disabled(true).opacity(0.6)
						ActionCard(
							action: self.goNextPage,
							textTitle: "Достижения",
							textBody: "Обратная связь по достижениям и проектам",
                            icon: "home__projects"
						).disabled(true).opacity(0.6)
						ActionCard(
							action: self.goNextPage,
							textTitle: "Профоценка SberProfi",
							textBody: "Оценка уровня профессионального мастерства",
							icon: "home__sberprofi"
						).disabled(true).opacity(0.6)
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
			//.toast(isShowing: self.error.errorHappened, text: Text(String(self.error.errorText!)))
			.onAppear(perform: {
				self.store.dispatch(usersActions.pendingGetMe)
//				self.store.dispatch(thanksActions.pendingGetThanksCount)
				
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

//
//-------------------------------------------------------------------------
//Меню Входящие-Запросы-Недвание
//func RecentMenu()-> HorizontalMenu {
//
//	//	self.selectedTab = HorizontalMenu().text[]
//
//
//
//	return testMenu
//}

/**Превью*/
struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage(store: AppMain().store)
    }
}
