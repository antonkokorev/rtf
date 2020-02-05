//
//  StartPage.swift
//  rtf
//
//  Created by антон on 13.01.2020.
//  Copyright © 2020 team. All rights reserved.
//
import SwiftUI
import PartialSheet
import RxSwift

func greetUser(msg:String) {
	print(msg)
}
struct StartPage: View {
	//=====================================================================================================================================
	/** подписки из store **/
	//@EnvironmentObject var search: TextModel

	/** главный store **/
	@ObservedObject var store = ObservableState(store: mainStore)
    @ObservedObject var storeNew = MyStore(store: mStore)
	/** стейты **/
	@ObservedObject var recentUsers: UsersRecentState = ObservableState(store: mainStore).state.usersRecentSubState
	@ObservedObject var requestUsers: usersRequestState = ObservableState(store: mainStore).state.usersRequestSubState
	@ObservedObject var users: UsersState = ObservableState(store: mainStore).state.usersSubState
	@ObservedObject var favUsers: usersFavouriteState = ObservableState(store: mainStore).state.usersFavouriteSubState
	@ObservedObject var thanks: thanksState = ObservableState(store: mainStore).state.thanksSubState
	@ObservedObject var error: ErrorState = ObservableState(store: mainStore).state.errorSubState
	@ObservedObject var historyList: usersHistoryState = ObservableState(store: mainStore).state.userHistorySubState
    init(){
//        do {
//          print("!!!", try storeNew.store.states["me"]?.value() ?? "")
//              } catch {
//                     //print(error)
//                 }
        
        storeNew.dispatch(action: "pendingGetMe")
        
        _  = storeNew.store.states["me"]?.subscribe(onNext: { (data:Any) in
             print("@@@data@@@   \(data)")
        })
        
        
//      MyStore.states["me"]?.asObserver().subscribe(onNext: { string in
//            print("First Subscription: ", string)
//        })
       // MyStore.states["me"]?.onNext("HI")
        
    }
	//=====================================================================================================================================
	/** локальный state, изменяемые переменные **/
	
	@State var historyPage: Bool = false
	/**Модальные окна*/
	@State var feedbackModal:Bool = false
	@State var historyModal:Bool = false
	@State var statisticsModal:Bool = false
	@State var historyUser:IUser = initIUser()
	/** индикатор для выбора пункта меню **/
	@State var activeCarousel: Int = 0
	/** индикатор для выбора пункта меню **/
	@State var activeBinaryMenu: Int = 0
	@State private var showFeedBackPage = false
	@State private var longer: Bool = false
	//=====================================================================================================================================
	/** функция переход на страницу истории  по конкретному юзеру*/
	private  func getHistoryByUser(userId:IUser) -> Void {
		self.historyUser = userId
		self.historyPage = true
	}
	//=====================================================================================================================================
	/** функция обработка кнопок тайлов*/
	private  func goNextPage(page:String) -> Void {
		switch page {
		case "История":
        
			historyModal = true
			self.store.dispatch(usersHistoryActions.pendingGetHistoryList)
		case "Статистика":
			statisticsModal = true
		case "home__feedback":
			self.store.dispatch(usersFavouriteActions.pendingGetFavFeedbackUsers)
			feedbackModal = true
		default:
			break
		}
	}
	//=====================================================================================================================================
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
				if ( user.bAddButton != true) {
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
	//=====================================================================================================================================
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
								.sheet(isPresented: $statisticsModal) {
									StatisticsPage()
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
                            Text("")
                           // FeedBackPage().environmentObject(self.search)
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
					
					/**Минимальный отступ от нижнего кра  я экрана*/
					Spacer(minLength: 25)
				}
				.padding(.horizontal, 30)
			}
		}
		.padding(.top, 10)
		.onAppear(perform: {
			self.store.dispatch(usersActions.pendingGetMe)
			//				self.store.dispatch(thanksActions.pendingGetThanksCount)
			self.store.dispatch(usersRecentActions.pendingGetRecentUsers)
			self.store.dispatch(usersHistoryActions.pendingGetHistoryList)
			self.store.dispatch(feedbackPropsActions.pendingGetAllCompetences)
		})
			/** список юзеров в истории*/
			.partialSheet(presented: $historyModal) {
				HistoryPopup(historyList: self.historyList.historyList, action: self.getHistoryByUser)
					.frame(height: 300)
		}
			/** страница истории*/
			.sheet(isPresented: self.$historyPage) {
				HistoryPage(respondent: self.historyUser)
		}
	}
	
	
	
}

//=====================================================================================================================================
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
//=====================================================================================================================================

/**Превью*/
struct StartPage_Previews: PreviewProvider {
	static var previews: some View {
		StartPage()
	}
}
