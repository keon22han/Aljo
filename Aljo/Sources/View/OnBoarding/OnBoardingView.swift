import Foundation
import SwiftUI
import ComposableArchitecture

struct OnBoardingView : View {
    @Bindable var store : StoreOf<OnboardingReducer>
    
    var body: some View {
        VStack {
            TabView {
                OnboardingPageView(imageName: "bell", mainString: "First", subString: "first")
                    .background(Color.white)
                
                OnboardingPageView(imageName: "bookmark", mainString: "Second", subString: "second")
                    .background(Color.white)
                
                OnboardingPageView(imageName: "airplane", mainString: "Third", subString: "third")
                    .background(Color.white)
                
                OnboardingPageView(imageName: "house", mainString: "Fourth", subString: "fourth")
                    .background(Color.white)
            }
            .tabViewStyle(PageTabViewStyle())
            
            Button("메인화면으로") {
                self.store.send(.mainButtonClicked)
            }
        }
        .background(Color.white)
    }
}
