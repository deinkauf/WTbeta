//
//  DogParkCard.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/23/21.
//

import SwiftUI

struct DogParkCard: View {
    
    @EnvironmentObject var userVM: UserVM
    var dogPark: DogPark
    var dogCount: Int
    
    var body: some View {
        ZStack {
            
            //Rectangle 2
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(
                        gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.8666666667, blue: 0.5803921569, alpha: 1))]),
                        startPoint: .leading,
                        endPoint: .trailing))
                .frame(width: 350, height: 160)
                .shadow(color: .gray, radius: 10, x: 0.0, y: 10)
                .overlay(
                    HStack {
                        
                        VStack(alignment: .leading) {
                            //University Dog Park
                            Text(dogPark.name ?? "no name").font(.system(size: 25, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            
                            //Active
                            Text("Active").font(.system(size: 16, weight: .semibold)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)))
                            
                            Spacer()
                            
                            //Hours: 8am - 8pm
                            Text("Hours: 8am - 8pm").font(.system(size: 12, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)))
                            
                            //3021 University Park Dr.
                            Text("3021 University Park Dr.").font(.system(size: 12, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        }
                        .padding(15)
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            ZStack {
                                //Star
                                Image(systemName: userVM.user.defaultDogParkID == dogPark.id ? "star.fill" : "star")
                                    .foregroundColor(.white)
                                    .frame(width: 24, height: 24)
                                    .onTapGesture {
                                        userVM.user.defaultDogParkID == dogPark.id ? userVM.removeDefaultDogPark() : userVM.setDefaultDogPark(dogParkID: dogPark.id!)
                                    }
                            }
                            Spacer()
                            ZStack {
                                //Paw
                                Circle()
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.white)
                                    .frame(width: 52, height: 52)
                                //14
                                Text("\(dogCount)").font(.system(size: 40, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            }
                        }
                        .padding(15)
                    }
                )
                
        }
    }
}

//struct DogParkCard_Previews: PreviewProvider {
//    static var previews: some View {
//        DogParkCard()
//    }
//}
