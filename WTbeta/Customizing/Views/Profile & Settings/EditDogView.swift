//
//  EditDogView.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/29/21.
//
///TODO
///Display Dog Profile Picture in accordance to the dog ID and storage manager reference
///enable the user to update the picture

import SwiftUI

struct EditDogView: View {
    
    @EnvironmentObject var userVM: UserVM
    
    var storageManager = StorageManager()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var updated: Bool = false
    
    @State var dogID: String = ""
    @State var name: String = ""
    @State var breed: String = ""
    @State var age: String = ""
    @State var bio: String = ""
    
    //assign to dogs current pic
    var placeholder: String = "pawprint.circle"
    @State var profilePic = UIImage()
    @State var showCameraSheet = false
    @State var showLibrarySheet = false
    @State var cameraDialog = false
    
    @State var deleteDialog = false
    
    var body: some View {
        
        ZStack {
            
            //replace color with background image
            //                backgroundColor
            //                    .ignoresSafeArea(edges: .all)
            VStack {
                VStack(spacing: 16) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            //TODO -- ADD PROGRESS TRACKER AT BOTTOM
                            //TITLE
                            Text("Edit Dog")
                                .font(Font.largeTitle.bold())
                                .foregroundColor(.white)
                            
                            //SUBTITLE
                            Text("Tap the image below to update your profile picture")
                                .font(.subheadline)
                                .foregroundColor(Color.white.opacity(0.7))
                        }
                        Spacer()
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white.opacity(0.7))
                                .aspectRatio(contentMode: .fill)
                                .padding(.horizontal)
                        }
                    }
                    
                    VStack(alignment: .center) {
                        //Conditional to check for photo content, displays placeholder symbol if no picture added yet
                        if profilePic == UIImage() {
                            Image(placeholder)
                                .resizable()
                                .cornerRadius(50)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .onTapGesture {
                                    self.cameraDialog = true
                                }
                                .actionSheet(isPresented: $cameraDialog) {
                                    ActionSheet(title: Text("Choose a New Photo"), message: Text("Pick a photo you like"),
                                                buttons: [
                                                    .default(Text("Camera")) {
                                                        userVM.deleteDog(dogID: dogID)
                                                    },
                                                    .default(Text("Library")) {
                                                        userVM.deleteDog(dogID: dogID)
                                                    },
                                                    .cancel()
                                                ])
                                }
                        } else {
                            Image(uiImage: self.profilePic)
                                .resizable()
                                .cornerRadius(50)
                                .frame(width: 100, height: 100)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .onTapGesture {
                                    self.cameraDialog = true
                                }
                                .actionSheet(isPresented: $cameraDialog) {
                                    ActionSheet(title: Text("Choose a New Photo"), message: Text("Pick a photo you like"),
                                                buttons: [
                                                    .default(Text("Camera")) {
                                                        showCameraSheet = true
                                                    },
                                                    .default(Text("Library")) {
                                                        showLibrarySheet = true
                                                    },
                                                    .cancel()
                                                ])
                                }
                        }
                        
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        //DOG NAME
                        CustomTextField(symbolName: "pawprint.fill", textFieldtext: "Your Dog's Name", userFieldEntry: $name)
                        //BREED
                        CustomTextField(symbolName: "rosette", textFieldtext: "Breed Type", userFieldEntry: $breed)
                        //AGE
                        CustomNumField(symbolName: "123.rectangle.fill", textFieldtext: "Age", userFieldEntry: $age)
                        //BIO
                        CustomTextField(symbolName: "plus.bubble", textFieldtext: "Make it fun!", userFieldEntry: $bio)
                        
                        //Select Profile Pic from Library
                        .sheet(isPresented: $showLibrarySheet) {
                            ImagePicker(sourceType: .photoLibrary,
                                        selectedImage: $profilePic)
                        }
                        
                        //Take Profile Pic with Camera
                        .sheet(isPresented: $showCameraSheet){
                            ImagePicker(sourceType: .camera, selectedImage: $profilePic)
                        }
                        
                        //NEXT BUTTON
                        VStack{
                            
                            Spacer()
                            
                            if name != "" && breed != "" && age != "" && bio != "" {
                                Button {
                                    userVM.updateDog(dogID: dogID, name: name, breed: breed, bio: bio, age: age, profilePic: profilePic)
                                    self.presentationMode.wrappedValue.dismiss()
                                } label: {
                                    GlowRectangle(text: "Update")
                                }
                            } else {
                                GlowRectangle(text: "Update")
                                    .opacity(0.5)
                            }
                            Spacer()
                            Image(systemName: "trash")
                                .foregroundColor(Color.white.opacity(0.7))
                                .padding(.horizontal, 10)
                                .onTapGesture {
                                    self.deleteDialog = true
                                }
                                .actionSheet(isPresented: $deleteDialog) {
                                    ActionSheet(title: Text("Title"), message: Text("Message"),
                                                buttons: [
                                                    .default(Text("Delete")) {
                                                        userVM.deleteDog(dogID: dogID)
                                                    },
                                                    .cancel()
                                                ])
                                }
                        }
                        .padding(.top)
                    }
                }
                .padding(20)
                .padding(.top)
            }
            .onBoardingFrame()
        }
        .navigationBarHidden(true)
    }
}

//struct EditDogView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditDogView()
//    }
//}
