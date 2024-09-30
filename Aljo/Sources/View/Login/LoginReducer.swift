import Foundation
import ComposableArchitecture
import KakaoSDKAuth

// MARK: Reducer Macro available upper iOS 17.0 , Reducer 프로토콜 채택
struct LoginReducer : Reducer {
    
    @ObservableState
    struct State : Equatable {
        var child = OnboardingReducer.State()
        var isLoading = false
        var loginCompleted = false
        var shouldShowOnboarding = true
    }
    
    @CasePathable
    enum Action: BindableAction {
        case child(OnboardingReducer.Action)
        case binding(BindingAction<State>)
        case loginButtonClicked
        case kakaoLoginSuccessed(OAuthToken)
        case kakaoLoginErrorOccured
        case completeOnboarding
    }
    
    var body: some Reducer<State, Action> {
        
        // MARK: body 프로퍼티 안에 Scope를 사용하여 자식 Reducer 정의
        Scope(state: \.child, action: \.child) {
            OnboardingReducer()
        }
        
        BindingReducer() // MARK: (24.09.29) State, Action 간 바인딩 역할 (State 업데이트 발생 -> BindingReducer가 State값, Action 수신하여 Reducer 클로저 내 도메인 로직 처리 및 결과 State 반영) 공부 필요
        
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
                
            case .loginButtonClicked:
                state.isLoading = true
                
                return .run { send in
                    do {
                        let oauthToken = try await LoginUtil.shared.loginWithKakaoAccountAsync()
                        
                        if let oauthToken = oauthToken {
                            print("loginWithKakaoTalk() success: \(oauthToken)")
                            await send(.kakaoLoginSuccessed(oauthToken))
                        }
                    } catch {
                        print("loginWithKakaoTalk() failed: \(error.localizedDescription)")
                        await send(.kakaoLoginErrorOccured)
                    }
                }
                
            case .kakaoLoginSuccessed(_) :
                state.isLoading = false
                state.loginCompleted = true
                return .none
                
            case .kakaoLoginErrorOccured :
                state.isLoading = false
                return .none
                
            case .completeOnboarding :
                state.shouldShowOnboarding.toggle()
                return .none
                
            case .child(_):
                print("child action called")
                
                return .none
            }
        }
    }
}
