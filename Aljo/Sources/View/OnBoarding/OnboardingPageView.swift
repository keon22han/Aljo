import Foundation
import SwiftUI

struct OnboardingPageView: View {
    
    var imageName: String = ""
    var mainString: String = ""
    var subString: String = ""
    
    init(imageName: String, mainString: String, subString: String) {
        self.imageName = imageName
        self.mainString = mainString
        self.subString = subString
    }
    
    var body: some View {
        VStack {
            Image(systemName: self.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 200)
                .padding()
            
            Text(self.mainString)
                .font(.system(size: 42))
                .padding()
            
            Text(self.subString)
                .font(.system(size: 42))
                .foregroundColor(Color(.secondaryLabel))
                .padding()
        }
    }
}
