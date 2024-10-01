import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Bindable var store : StoreOf<LoginReducer>
    
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $store.currentOnboardingIndex) {
                    OnboardingPageView(imageName: "Onboard1")
                        .background(Color.white)
                        .tag(0)
                    
                    OnboardingPageView(imageName: "Onboard2")
                        .background(Color.white)
                        .tag(1)
                    
                    OnboardingPageView(imageName: "Onboard3")
                        .background(Color.white)
                        .tag(2)
                    
                    OnboardingPageView(imageName: "Onboard4")
                        .background(Color.white)
                        .tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .overlay(alignment: .bottom, content: {
                    CustomIndicator(currentIndex: store.currentOnboardingIndex)
                }).animation(.easeInOut, value: store.currentOnboardingIndex)
                
                Button(action: {
                    self.store.send(.loginButtonClicked)
                }) {
                    Image("kakao_login_wide")
                        .resizable()
                        .frame(width: 300, height: 45)
                        .aspectRatio(contentMode: .fit)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
            }
            .background(Color.white)
        }.loadingIndicator(isLoading: self.store.isLoading)
    }
}

struct CustomIndicator: View {
  
  let currentIndex: Int
  
  var body: some View {
    ZStack{
        HStack(spacing: 10) {
            ForEach(0..<4) { index in
                Capsule()
                    .frame(width: currentIndex == index ? 16 : 6, height: 6)
                    .opacity(currentIndex == index ? 1 : 0.5)
                    .foregroundStyle(currentIndex == index ? .black : .gray)
                    .tag(index)
        }
      }
    }
    .padding(.bottom, 24)
  }
}

struct OnboardingPageView: View {
    
    var imageName: String
    
    var body: some View {
        VStack {
            Image(self.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
        }
    }
}

