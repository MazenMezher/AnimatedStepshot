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
        
        ZStack {
            Color("Background").ignoresSafeArea()
            ScrollView {
                content
            }
        }
    }
    
    var content: some View {
        
        VStack(alignment: .trailing, spacing: 0) {

            VStack(spacing: 20) {
                
                Text("Jobs")
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
                    .background(.linearGradient(colors: [.black.opacity(1), .black.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))

                    .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 12)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                 
                Image(uiImage: image ?? UIImage(named: "placeholder")!)
                
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 120)
                    .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: 12)
                    .shadow(color: .gray.opacity(0.3), radius: 2, x: 0, y: 1)
                
                Text("placeholder Text")
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

