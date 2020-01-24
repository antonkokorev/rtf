////
//// Created by антон on 24.01.2020.
//// Copyright (c) 2020 team. All rights reserved.
////
//
//import Foundation
//import SwiftUI
//
//
//
//    struct ContentView: View {
//      var body: some View {
//        QGrid(Storage.people, columns: 3) { GridCell(person: $0) }
//      }
//    }
//
//    struct GridCell: View {
//      var person: Person
//
//      var body: some View {
//        VStack() {
//          Image(person.imageName)
//            .resizable()
//            .scaledToFit()
//            .clipShape(Circle())
//            .shadow(color: .primary, radius: 5)
//            .padding([.horizontal, .top], 7)
//          Text(person.firstName).lineLimit(1)
//          Text(person.lastName).lineLimit(1)
//        }
//      }
//    }
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
