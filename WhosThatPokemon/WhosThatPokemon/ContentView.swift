//
//  ContentView.swift
//  WhosThatPokemon
//
//  Created by Henry Heese on 12/8/22.
//

import SwiftUI

struct ContentView: View {
    @State var isPresenting: Bool = false
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @ObservedObject var classifier: ImageClassifier
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                Text("Who's That Pokemon?!?")
                    .font(.title)
                    .foregroundColor(.gray)
                HStack{
                    Image(systemName: "photo")
                        .onTapGesture {
                            isPresenting = true
                            sourceType = .photoLibrary
                        }
                    
                    Image(systemName: "camera")
                        .onTapGesture {
                            isPresenting = true
                            sourceType = .camera
                        }
                }
                .font(.title)
                .foregroundColor(.blue)
                
                Rectangle()
                    .strokeBorder()
                    .foregroundColor(.yellow)
                    .overlay(
                        Group {
                            if uiImage != nil {
                                Image(uiImage: uiImage!)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    )
                
                
                VStack{
                    Button(action: {
                        if uiImage != nil {
                            classifier.detect(uiImage: uiImage!)
                        }
                    }) {
                        Circle()
                            .foregroundColor(.orange)
                            .font(.title)
                            .frame(width:50)
                    }
                    
                    
                    Group {
                        if let imageClass = classifier.imageClass {
                            HStack{
                                Text("Image categories:")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                Text(imageClass)
                                    .bold()
                                    .foregroundColor(.white)
                            }
                        } else {
                            HStack{
                                Text("Image categories: NA")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .font(.subheadline)
                    .padding()
                    
                }
            }
            
            .sheet(isPresented: $isPresenting){
                ImagePicker(uiImage: $uiImage, isPresenting:  $isPresenting, sourceType: $sourceType)
                    .onDisappear{
                        if uiImage != nil {
                            classifier.detect(uiImage: uiImage!)
                        }
                    }
            }
            
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(classifier: ImageClassifier())
    }
}

