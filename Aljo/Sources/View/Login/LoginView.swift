import SwiftUI
import ComposableArchitecture

// MARK: 현재는 앱 시작 시 온보딩 창 띄워짐 (24.09.29)
struct LoginView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Bindable var loginStore : StoreOf<LoginReducer>
    
    var body: some View {
        NavigationView {
            VStack {
                Text("알죠")
                    .font(.system(size: 40, weight: .bold))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                Button(action: {
                    self.loginStore.send(.loginButtonClicked)
                }) {
                    Image("kakao_login_default")
                        .resizable()
                        .frame(width: 200, height: 50)
                        .aspectRatio(contentMode: .fit)
                }
            }
            
        }.loadingIndicator(isLoading: self.loginStore.isLoading)
        // TODO: OnBoarding, 기본 설정 페이지로 코드 이동 필요 (24.09.29)
            .fullScreenCover(isPresented: $loginStore.shouldShowOnboarding, content: {
                OnBoardingView(
                    store: self.loginStore.scope(state: \.onBoardingState, action: \.onBoarding)
                )
            })
    }
}
