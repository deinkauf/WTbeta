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
        if userVM.checkedIn {
            DogParkView(dogParkVM: DogParkVM(dogParkID: userVM.dogParkCheckedInto))
        }
        else if userVM.hasDefaultDogPark {
            DogParkView(dogParkVM: DogParkVM(dogParkID: self.userVM.user.defaultDogParkID!))
        } else {
            ProgressView()
                .onAppear {
                    userVM.checkDefaultDogPark()
                }
        }
    }
    
    
}

//struct DefaultDogParkView_Previews: PreviewProvider {
//    static var previews: some View {
//        DefaultDogParkView()
//    }
//}
