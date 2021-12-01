//
//  FirebaseImage.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/30/21.
//

import SwiftUI

struct FirebaseImage : View {
    
    var dog: Dog
    
    @ObservedObject private var imageLoader: Loader
    
    let placeholder = UIImage(named: "pawprint.circle")!

    init(dog: Dog) {
        self.dog = dog
        self.imageLoader = Loader(dog: dog)
    }

    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }

    var body: some View {
        Image(uiImage: image ?? placeholder)
            .resizable()
            .cornerRadius(50)
            .frame(width: 80, height: 80)
            .foregroundColor(.white)
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
    }
}

//struct FirebaseImage_Previews: PreviewProvider {
//    static var previews: some View {
//        FirebaseImage()
//    }
//}
