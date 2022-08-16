//
//  ImagePickerView.swift
//  AnimatedStepshot
//
//  Created by Mazen Mezher on 2022-06-10.
//
import MapKit
import SwiftUI



struct ImagePickerView: View {
        @StateObject private var viewModel = ContentViewModel()
        @State private var showSheet: Bool = false
        @State private var showImagePicker: Bool = false
        @State private var sourceType: UIImagePickerController.SourceType = .camera
        @State private var image: UIImage?
        @State var placeHolderText = "I'm a placeholder"

        
        var body: some View {
            
         
            NavigationView {
                ZStack(alignment: .top){
                    
                    Color("Background").ignoresSafeArea()
                    
                    VStack{
                        CustomButton1(placeHolderText: self.$placeHolderText)
                        Text("Camera mode")
                            .customFont(.largeTitle)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        
                        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                        
                            .frame(width: 350,height: 300, alignment: .topLeading)
                            .cornerRadius(30)
                            .accentColor(Color(.systemPink))
                            .onAppear {
                                viewModel.checkIfLocationServicesIsEnabled()
                            }
                        
                        Image(uiImage: image ?? UIImage(named: "placeholder")!)
                            
                            .renderingMode(.original)
                        
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 120)
                        
                        Text("\(self.placeHolderText)")
                            .font(.system(size: 20))
                        
                        
                        Button("Take Photo") {
                            self.showSheet = true
                        }
                            .font(.system(size: 25))
                        
                            .actionSheet(isPresented: $showSheet) {
                                ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                                    .default(Text("Photo Library")) {
                                        self.showImagePicker = true
                                        self.sourceType = .photoLibrary
                                    },
                                    .default(Text("Camera")) {
                                        self.showImagePicker = true
                                        self.sourceType = .camera
                                    },
                                    .cancel()
                                ])
                        }
                        
                    }
                   
                    }
                

               
                
                
            
                
            }.sheet(isPresented: $showImagePicker) {
                ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
                
            }
        }
    
}



struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView()
    }
}

