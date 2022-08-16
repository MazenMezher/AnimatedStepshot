import Foundation
import SwiftUI


//Below is code to get image and give it a logo value

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    @State private var Result: ResultItem?
    
    
    init(image: Binding<UIImage?>, isShown: Binding<Bool>) {
        _image = image
        _isShown = isShown
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = uiImage
            isShown = false
            
            let data = uiImage.jpegData(compressionQuality: 0.7)
            let strBase64 = data!.base64EncodedString()
            
            let url = URL(string: "http://localhost:8080/detect")!
            
            var request = URLRequest(url: url)
            
            // method ,body, headers
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: AnyHashable] = [
                "content": strBase64
            ]
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
            
            // Make the request
            let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    
                }
                
                if let decodedData = try? JSONDecoder().decode(ResultItem.self, from: data) {
                    
                    print("This is decodedData: \(decodedData.description)")
                    
                    DispatchQueue.main.async {
                        self.Result = decodedData
                        
                    }
                }
            }
            task.resume()
        }
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
    
}

struct CustomButton1: View {
    
    @Binding var placeHolderText: String
    
    var body: some View {
        Button("Sending data says"){ self.placeHolderText = "Works"}
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerCoordinator
    
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePickerCoordinator(image: $image, isShown: $isShown)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
        
    }
    
}

struct ResultItem: Decodable {
    let description: String
}
