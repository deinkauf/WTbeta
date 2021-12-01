//
//  DogCard.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/23/21.
//
import SwiftUI
import Firebase
import FirebaseStorage

struct DogCard: View {
    
    var dog: Dog
    var privateCard: Bool = false
    
    var body: some View {
        ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9176450372, green: 0.3724507987, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.5216394663, green: 0.2060443163, blue: 1, alpha: 1))]),
                            startPoint: .leading, endPoint: .trailing))
                    .frame(width: 350, height: 215)
                    .overlay(
                        HStack {
                            
                            VStack(alignment: .leading){
                                //Profile Picture
                                FirebaseImage(dog: dog)
                                                
                                Spacer()
                                Spacer()
                                //Bio
                                Text(dog.bio ?? "no bio").font(.system(size: 12, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)))
                                Spacer()
                            }
                            .padding()
                            .padding(.horizontal, 7)
                            Spacer()
                          
                            VStack(alignment: .trailing) {
                                //Name
                                Text(dog.name ?? "no name").font(.system(size: 25, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.trailing)
                                    .padding(.vertical, 6)
                                
                                //Breed
                                Text(dog.breed ?? "no breed").font(.system(size: 14, weight: .semibold)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)))
                                    .padding(.vertical, 6)
                                                  
                                //Age
                                Text(dog.age ?? "no age").font(.system(size: 14, weight: .semibold)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7))).multilineTextAlignment(.trailing)
                                    .padding(.vertical, 6)
                                
                                Spacer()
                                
                                if privateCard == true {
                                    HStack {
                                        //Edit Icon
                                        NavigationLink(
                                            destination: EditDogView(dogID: dog.id ?? "", name: dog.name ?? "", breed: dog.breed ?? "", age: dog.age ?? "", bio: dog.bio ?? ""),
                                            label: {
                                                Image(systemName: "square.and.pencil")
                                                    .foregroundColor(.white)
                                                    .frame(width: 24, height: 24)
                                            })
                                        
                                        //Share Icon
//                                        Image(systemName: "square.and.arrow.up")
//                                            .foregroundColor(.white)
//                                            .frame(width: 24, height: 24)
                                    }
                                }
                              }
                            .padding()
                            .padding(.horizontal, 7)
                        }
                    )
        }
    }
}
