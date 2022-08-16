import Foundation
import SwiftUI

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    
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
            
            guard let url = URL(string: "http://localhost:8080/detect") else {
                return
            }
            
            var request = URLRequest(url: url)
            
            // method ,body, headers
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: AnyHashable] = [
                "content": strBase64
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            // Make the request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                print(response)
                print("Test for gitupload/commit")
                var result: Result?
                do{
                    let jsonData = try Data(contentsOf: url)
                    result = try JSONDecoder().decode(Result.self, from: jsonData)
                    
                    if let result = result {
                        print(result)
                    } else {
                        print("Failed")
                    }
                }catch {
                    print("Error: \(error)")
                }
                
            }
            task.resume()
        }
        
        
    }
    
    struct Result: Codable {
        let content: [ResultItem]
    }
    
    struct ResultItem: Codable {
        let content: String
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
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
