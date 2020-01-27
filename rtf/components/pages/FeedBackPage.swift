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
    @Published var searchTxt = ""
        {
        didSet {
            DispatchQueue.global(qos: .background).async {
                self.debouncedFunction(ITextStore.init(store: self.store, str: self.searchTxt))
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
        print(method)
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
        return NavigationView {
            VStack(alignment: .leading, spacing: 5) {
                
                if (self.textModel.searchTxt.count > 0 ) {
                    Text("Найдите пользователя и дайте оценку ") .foregroundColor(Color(red:0.54, green:0.57, blue:0.61))
                        .font(.custom("SBSansDisplay-Regular", size: 18)).padding()
                }else{
                    Text("Запросить или дать обратную связь у коллег для развития")
                        .foregroundColor(Color(red:0.54, green:0.57, blue:0.61))
                        .font(.custom("SBSansDisplay-Regular", size: 18))
                        .padding()
                }

                /** Поиск  **/
                SearchBar(self.store, $textModel.searchTxt, nil)
           
               /** Скрывает все, если есть найденые пользователи */
                if (self.textModel.searchTxt.count > 0 ) {
                
                    SearchList(store: self.store, aSearchUsers: self.search.collection ?? [],aFavUsers: self.favUsers.collection, action:self.userClick)
                } else {
                    Text("Недавние")
                        .foregroundColor(Color(red:0.00, green:0.00, blue:0.00))
                        .font(.custom("SBSansDisplay-Regular", size: 20))
                        .bold()
                        .padding()
                    /** Карусель с юзерами **/
                    Carousel(self.users.collection, action: userClick)

                    /** Кнопки для управления юзерами **/
                    HStack{
                        Text("Избранное")
                            .foregroundColor(Color(red:0.00, green:0.00, blue:0.00))
                            .font(.custom("SBSansDisplay-Regular", size: 20))
                            .bold()
                            .padding()
                        Spacer()
                        if (self.editMode){
                            Button(action: {
                                self.changeEditMode(self.editMode)

                            }, label: {
                                Text("Сохранить")
                                    .foregroundColor(Color(red:0.20, green:0.32, blue:1.00))
                                    .font(.custom("SBSansDisplay-Regular", size: 18))
                                    .padding()
                            })
                        } else {
                            Button(action: {
                                self.changeEditMode(self.editMode)
                            }, label: {
                                Text("Изменить")
                                    .foregroundColor(Color(red:0.54, green:0.57, blue:0.61))
                                    .font(.custom("SBSansDisplay-Regular", size: 18))
                                    .padding()
                            })
                        }
                    }
                    /** грид избранных юзеров, на вход [IUser] **/
                FavouriteUsersGrid(store: self.store, users: self.favUsers.collection, editMode: self.editMode).padding(.top ,35)
                }
                /** двигает все на верх **/
                Spacer()
            }
            .navigationBarTitle("Обратная связь")
            
        }.partialSheet(presented: $modalPresented) {
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
