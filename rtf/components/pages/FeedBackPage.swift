//
//  FeedBackPage.swift
//  rtf
//
//  Created by антон on 13.01.2020.
//  Copyright © 2020 team. All rights reserved.
//
import SwiftUI
import PartialSheet


// todo: адовое извращение  для поиска с дебоунсом
class TextModel: ObservableObject {
	
	let debouncedFunction = debounce(interval: 800, queue: DispatchQueue.main, action: { (str: String) in
		(ObservableState(store: mainStore)).dispatch(searchActions.pendingSearch(str))
	})
	
	@Published var searchText = ""
		{
		didSet {
			DispatchQueue.global(qos: .background).async {
				self.debouncedFunction(self.searchText)
			}
		}
	}
}
//struct GlobalVar {
//     let subjectStr = BehaviorSubject<String>(value:"")
//    let sub = subjectStr.subscribe(onNext:{ str in
//    print(str)
//    })
//}




/** страничка коллеги **/
struct FeedBackPage: View {
	@EnvironmentObject var textModel: TextModel
	/** подписки из store **/
//	@ObservedObject var textModel: TextModel = TextModel()
	//@ObservedObject var store = ObservableState(store: mainStore)
    @ObservedObject var users: UsersRecentState = ObservableState(store: mainStore).state.usersRecentSubState

	@ObservedObject var error: ErrorState = ObservableState(store: mainStore).state.errorSubState

	//=====================================================================================================================================
	
	/** локальный state, изменяемые переменные **/
	@State var searchTxt: String = ""
	@State var editMode: Bool = false
	@State var bAddToFav: Bool = false
	@State var estimateUserModal: Bool = false
	@State private var modalPresented: Bool = false
	@State var selectedUser:IUser = initIUser()
	
	//=====================================================================================================================================
	/** кастомные функции **/
	func userClick(user:IUser){
		self.selectedUser = user
		modalPresented = true
	}
	func methodClick(method:String){
		modalPresented = false
		estimateUserModal = true
	}
	
	func changeEditMode (_ mode: Bool) -> Void {
		self.editMode = !mode
	}
	var body: some View {
		if self.error.errorHappened {
			DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
				self.error.errorHappened = false
			}
		}
		return
                
			VStack(alignment: .leading, spacing: 0) {
			Print("render")
				VStack(alignment:.leading){
					Text("Коллеги")
						.font(Font.Typography.sizingFont(font: .bold, size: .H1))
						.padding(.bottom, 10)
					
					if (self.textModel.searchText.count > 0 ) {
						Text("Найдите сотрудника Сбербанка, которому хотите дать обратную связь")
							.font(Font.Typography.sizingFont(font: .regular, size: .H3))
							.foregroundColor(Color.RTFPallete.textSecondary)
					}else{
						Text("Обратная связь по компетенциям и профессиональным навыкам")
							.font(Font.Typography.sizingFont(font: .regular, size: .H3))
							.foregroundColor(Color.RTFPallete.textSecondary)
					}
				}
				.padding(.top, 40)
				.padding(.bottom, 20)
				
				/** Поиск  **/
				SearchBar(searchTxt: $textModel.searchText)
					.padding(.bottom, 20)
			
                
				/** Скрывает все, если есть найденые пользователи */
                if (textModel.searchText.count > 0) {
             //   SearchList(action:self.userClick)
				} else {
					Text("Недавние")
						.font(Font.Typography.sizingFont(font: .semibold, size: .H2))
						.foregroundColor(Color.RTFPallete.textDefault)
					
					/** Карусель с юзерами **/
					Carousel(self.users.collection, action: userClick)
						.padding(.leading, -30)
						.padding(.top, 15)
						.padding(.bottom, 30)
					
					/** Кнопки для управления юзерами **/
					HStack{
						Text("Избранное")
							.font(Font.Typography.sizingFont(font: .semibold, size: .H2))
							.foregroundColor(Color.RTFPallete.textDefault)
						
						Spacer()
						if (self.editMode){
							Button(action: {
								self.changeEditMode(self.editMode)
								
							}, label: {
								Text("Сохранить")
									.font(Font.Typography.sizingFont(font: .semibold, size: .H3))
									.foregroundColor(Color.RTFPallete.textSecondary)
							})
						} else {
							Button(action: {
								self.changeEditMode(self.editMode)
							}, label: {
								Text("Изменить")
									.font(Font.Typography.sizingFont(font: .semibold, size: .H3))
									.foregroundColor(Color.RTFPallete.textSecondary)
							})
                        }}
					}
					.padding(.bottom, 15)
					/** грид избранных юзеров, на вход [IUser] **/
					
					FavouriteUsersGrid( editMode: self.editMode, action:self.userClick)
					Spacer()
				
				/** двигает все на верх **/
				Spacer()
			}
			.padding(.horizontal, 30)
			.modifier(DismissingKeyboard()).partialSheet(presented: $modalPresented) {
				VStack {
					UserFeedbackPopup(user: self.selectedUser, action:self.methodClick)
						.frame(height: 450)
					
				}
			} .sheet(isPresented: $estimateUserModal) {
				FeedBackRequestPage()
			}
			.toast(isShowing: self.error.errorHappened, text: Text(String(self.error.errorText!)))
	}
}
