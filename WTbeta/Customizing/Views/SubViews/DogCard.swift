//
//  DogCard.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/23/21.
//

import SwiftUI

struct DogCard: View {
    
    @State var dog: Dog
    
    var body: some View {
        ZStack {
          //Rectangle 2
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9176450372, green: 0.3724507987, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.5216394663, green: 0.2060443163, blue: 1, alpha: 1))]),
                            startPoint: .leading, endPoint: .trailing))
                    .frame(width: 350, height: 215)
                    .shadow(color: .gray, radius: 10, x: 0.0, y: 10)
                    .overlay(
                        HStack {
                            
                            VStack(alignment: .leading){
                                //Profile Picture
                                Image("pawprint.circle")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 70, height: 70)
                                    .scaledToFit()
                                            
                                Spacer()
                                Spacer()
                                //Bio
                                    Text("This is where the the dogs bio will go when we add it.").font(.system(size: 12, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)))
                                Spacer()
                            }
                            .padding()
                          
                            VStack(alignment: .trailing) {
                                //Name
                                Text(dog.name ?? "no name").font(.system(size: 25, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.trailing)
                                    .padding(.vertical, 6)
                                
                                //Breed
                                Text("Dog's Breed").font(.system(size: 14, weight: .semibold)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)))
                                    .padding(.vertical, 6)
                                                  
                                //Age
                                Text("Age").font(.system(size: 14, weight: .semibold)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7))).multilineTextAlignment(.trailing)
                                    .padding(.vertical, 6)
                                
                                Spacer()
                                
                                HStack {
                                    //Edit Icon
                                    Image(systemName: "square.and.pencil")
                                        .foregroundColor(.white)
                                        .frame(width: 24, height: 24)

                                    //Share Icon
                                    Image(systemName: "square.and.arrow.up")
                                        .foregroundColor(.white)
                                        .frame(width: 24, height: 24)
                                }
                              }
                            .padding()
                        }
                    )
        }
    }
}

//struct DogCard_Previews: PreviewProvider {
//    static var previews: some View {
//        DogCard()
//    }
//}
