//
//  HomeView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/23/21.
//

import SwiftUI
import FirebaseFirestoreSwift

struct HomeView: View {
    
    @EnvironmentObject var userVM: UserVM
    
    var body: some View {
        
        if userVM.hasDefaultDogPark == false {
            ProgressView()
                .onAppear {
                    userVM.checkDefaultDogPark()
                }
            
        } else {
            DogParkView(dogParkVM: DogParkVM(dogParkID: self.userVM.user.defaultDogParkID!))
        }
    }
    
    
}

//struct DefaultDogParkView_Previews: PreviewProvider {
//    static var previews: some View {
//        DefaultDogParkView()
//    }
//}
