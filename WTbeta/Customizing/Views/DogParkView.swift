//
//  DogParkView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/23/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct DogParkView: View {
    
    @EnvironmentObject var userVM: UserVM
    @ObservedObject var dogParkVM: DogParkVM
    
    @State var dogsCheckingIn = [Dog]()
    
    @State private var showDogSelection = false
    
    
    var body: some View {
        
        if dogParkVM.dogPark != nil {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    DogParkCard(dogPark: dogParkVM.dogPark!, dogCount: dogParkVM.dogsCheckedIn.count)
                    ScrollView {
                        ForEach(dogParkVM.dogsCheckedIn) { dog in
                            DogCard(dog: dog, privateCard: false)
                        }
                    }
                }
                if !userVM.checkedIn || userVM.dogParkCheckedInto == dogParkVM.dogParkID {
                    Button {
                        userVM.checkedIn || dogsCheckedIn() ? checkOut() : showDogSelection.toggle()
                    } label: {
                        circleButton
                    }

                }
            }
            .sheet(isPresented: $showDogSelection) {
                dogSelectionView
            }

            
        } else { ProgressView()
//                .onAppear {
//                    self.dogParkVM.fetchData()
//                }
        }
            
            
    }
    
    // MARK -- SUB VIEWS
    var circleButton: some View {
        Circle()
            .frame(width: 60, height: 60)
            .foregroundColor(userVM.checkedIn || dogsCheckedIn() ? .red : .green)
//            .opacity(0.5)
            .padding(.vertical)
            .overlay(
                Image(systemName: userVM.checkedIn || dogsCheckedIn() ? "xmark" : "checkmark")
                    .resizable()
                    .foregroundColor(.white)
                    .scaledToFit()
                    .padding()
            )
    }
    
    
    var dogSelectionView: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                ScrollView {
                    ForEach(userVM.dogs) { dog in
                        Button {
                            dogSelect(dog: dog)
                        } label: {
                            DogCard(dog: dog)
                                .opacity(dogsCheckingIn.contains(where: { d in d.id == dog.id }) ? 0.5:1)
                        }

        //                DogCard(dog: dog)
        //                    .opacity(userVM.dogsCheckingIn.contains(where: { d in d.id == dog.id }) ? 1:0.5)
        //                    .onTapGesture {
        //                        userVM.dogsCheckingIn.contains(where: { d in d.id == dog.id }) ?
        //                        userVM.removeFromDogsCheckingIn(dog: dog) : userVM.addToDogsCheckingIn(dog: dog)
        //                    }
                    }
                }
                .padding(.top, 60)
            }
            if !dogsCheckingIn.isEmpty {
                circleButton
    //                .offset(y: 70)
                    .onTapGesture {
                        checkIn()
                    }
            }
        }
    }
    
    // MARK -- FUNCTIONS
    
    func dogsCheckedIn() -> Bool {
        var b = false
        for dog in userVM.dogs {
            b = dogParkVM.dogsCheckedIn.contains(where: { d in
                d.id == dog.id
            })
        }
        return b
    }
    
    func dogSelect(dog: Dog) {
        dogsCheckingIn.contains(where: { d in d.id == dog.id }) ?
        removeFromDogsCheckingIn(dog: dog) : addToDogsCheckingIn(dog: dog)
    }
    
    func addToDogsCheckingIn(dog: Dog) {
        dogsCheckingIn.append(dog)
    }
    
    func removeFromDogsCheckingIn(dog: Dog) {
        let i = dogsCheckingIn.firstIndex { d in
            d.id == dog.id
        }
        if let i = i {
            dogsCheckingIn.remove(at: i)
        }
    }
    
    func checkIn() {
        userVM.checkIn(dogParkID: dogParkVM.dogParkID)
        for dog in dogsCheckingIn {
            dogParkVM.checkInDog(dog: dog)
        }
        showDogSelection = false
        
    }
    func checkOut() {
        userVM.checkOut()
        for dog in userVM.dogs {
            dogParkVM.checkOutDog(dog: dog)
        }
        dogsCheckingIn.removeAll()
    }
}

struct DogParkView_Previews: PreviewProvider {
    static var previews: some View {
        DogParkView(dogParkVM: DogParkVM(dogParkID: "4cyDRp7hcMnO0jwfc5XU"))
    }
}


