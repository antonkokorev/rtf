//
//  FeedBackPage.swift
//  rtf
//
//  Created by антон on 13.01.2020.
//  Copyright © 2020 team. All rights reserved.
//
import SwiftUI
import PartialSheet
import URLImage

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

/** страничка коллеги **/
struct FeedBackPage: View {
    
    /** подписки из store **/
    @EnvironmentObject var textModel: TextModel 
    @ObservedObject var store = ObservableState(store: mainStore)
    @ObservedObject var favUsers: usersFavouriteState = ObservableState(store: mainStore).state.usersFavouriteSubState
    @ObservedObject var users: UsersRecentState = ObservableState(store: mainStore).state.usersRecentSubState
    @ObservedObject var search: SearchState = ObservableState(store: mainStore).state.searchSubState
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
    func searchFav() -> Void {
        print("!!!sfwf")
        self.bAddToFav = true
        
    }
    
    var body: some View {
        if self.error.errorHappened {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.error.errorHappened = false
            }
        }
        return
            
            VStack(alignment: .leading, spacing: 0) {
               
                    //--------------------------
                    VStack(alignment:.leading){
                        Text("Коллеги")
                            .font(Font.Typography.sizingFont(font: .bold, size: .H1))
                            .padding(.bottom, 10)
                            .padding(.horizontal, 30)
                        
                        Text("Обратная связь по компетенциям и профессиональным навыкам")
                            .font(Font.Typography.sizingFont(font: .regular, size: .H3))
                            .foregroundColor(Color.RTFPallete.textSecondary)
                            .padding(.horizontal, 30)
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 20)
                    //--------------------------
                    /** Поиск  **/
                    SearchBar(searchTxt: $textModel.searchText)
                        .padding(.bottom, 20)
                        .padding(.horizontal, 30)
                    //--------------------------
                    /** Скрывает все, если есть найденые пользователи */
                    if (self.store.state.searchSubState.bShowSearch){
                        SearchList(
                            aSearchUsers: self.search.collection ,
                            aFavUsers: self.favUsers.collection,
                            action:self.userClick
                        )
                    } else {
                        VStack(alignment: .leading){
                            Text("Недавние")
                                .font(Font.Typography.sizingFont(font: .semibold, size: .H2))
                                .foregroundColor(Color.RTFPallete.textDefault)
                            
                            /** Карусель с юзерами **/
                            Carousel(self.users.collection, action: userClick)
                                .padding(.leading, -30)
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
                                }
                            }
                            /** грид избранных юзеров, на вход [IUser] **/
                            
                            FavouriteUsersGrid(users: self.favUsers.collection, editMode: self.editMode, action:self.userClick, searchFav: searchFav)
                            
                        }.padding(.horizontal, 30)
                    }
                //--------------------------
                /** двигает все на верх **/
                Spacer().sheet(isPresented: self.$bAddToFav) {
                    SearchFavourite().environmentObject(self.textModel)
                }
                Spacer().sheet(isPresented: $estimateUserModal) {
                    FeedBackRequestPage(store: self.store)
                }
            }.modifier(DismissingKeyboard()).partialSheet(presented: $modalPresented) {
                VStack {
                    UserFeedbackPopup(user: self.selectedUser, action:self.methodClick)
                        .frame(height: 450)
                    
                }
            }
            .toast(isShowing: self.error.errorHappened, text: Text(String(self.error.errorText!)))
        //--------------------------
        
        
    }
}
