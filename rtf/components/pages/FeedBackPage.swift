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


struct ITextStore{
    var store : GlobalStore
    var str : String
}
// todo: адовое извращение  для поиска с дебоунсом
class TextModel: ObservableObject {
    let debouncedFunction = debounce(interval: 800, queue: DispatchQueue.main, action: { (this:ITextStore) in
        this.store.dispatch(searchActions.pendingSearch(this.str))
    })
    var store:GlobalStore
    init(store: GlobalStore) {
        self.store = store
    }
    @Published var searchText = ""
        {
        didSet {
            DispatchQueue.global(qos: .background).async {
                self.debouncedFunction(ITextStore.init(store: self.store, str: self.searchText))
            }
        }
    }
}


struct FeedBackPage: View {
    
    @State var searchTxt: String = ""
    @State var editMode: Bool = false
    @State var bAddToFav: Bool = false
    @State var estimateUserModal: Bool = false
    
    @ObservedObject var textModel :TextModel
    /* инициализатор store + state перед рендером */
    init(store: GlobalStore) {
        self.store = store
        self.favUsers = store.state.usersFavouriteSubState
        self.users = store.state.usersRecentSubState
        self.search = store.state.searchSubState
        self.error = store.state.errorSubState
        self.textModel = TextModel(store: store)
        
    }
    
    
    @State private var modalPresented: Bool = false
    @State var selectedUser:IUser = initIUser()
    @ObservedObject var favUsers: usersFavouriteState
    @ObservedObject var users: UsersRecentState
    @ObservedObject var search: SearchState
    @ObservedObject var error: ErrorState
    
    let store: GlobalStore
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
                
                SearchBar(store: self.store, searchTxt: $textModel.searchText)
                    .padding(.bottom, 20)
                
                /** Скрывает все, если есть найденые пользователи */
                if (self.textModel.searchText.count > 0 ) {
                    
                    SearchList(store: self.store, aSearchUsers: self.search.collection ,aFavUsers: self.favUsers.collection, action:self.userClick)
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
                        }
                    }
                    .padding(.bottom, 15)
                    /** грид избранных юзеров, на вход [IUser] **/
                    
                    FavouriteUsersGrid(store: self.store, users: self.favUsers.collection, editMode: self.editMode, action:self.userClick)
                    Spacer()
                }
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
                StatisticsPage(store: self.store)
            }
            .toast(isShowing: self.error.errorHappened, text: Text(String(self.error.errorText!)))
        
    }
}
