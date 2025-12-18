import SwiftUI
import UIKit // Needed for UIImage

struct ExerciseImageView: View {
    let assetImageName: String?
    let userImageBase64: String?
    
    var body: some View {
        Group {
            if let base64String = userImageBase64,
               let data = Data(base64Encoded: base64String),
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if let name = assetImageName,
                      let uiImage = UIImage(named: name) { // Try loading from assets
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                // Fallback placeholder if no image data or asset name found
                ZStack {
                    Color.gray.opacity(0.1)
                    Image(systemName: "dumbbell.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(20)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
