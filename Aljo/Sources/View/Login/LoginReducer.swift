import Foundation
import ComposableArchitecture
import KakaoSDKAuth

// MARK: Reducer Macro available upper iOS 17.0 , Reducer 프로토콜 채택
struct LoginReducer : Reducer {
    
    @ObservableState
    struct State : Equatable {
        var currentOnboardingIndex = 0
        var isLoading = false
        var shouldShowOnboarding = false
    }
    
    @CasePathable
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case loginButtonClicked
        case kakaoLoginSuccessed
        case kakaoLoginErrorOccured
        case kakaoLoginTokenNotExist
    }
    
    var body: some Reducer<State, Action> {
        
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
                            await send(.kakaoLoginSuccessed)
                        }
                    } catch {
                        print("loginWithKakaoTalk() failed: \(error.localizedDescription)")
                        await send(.kakaoLoginErrorOccured)
                    }
                }
                
            case .kakaoLoginSuccessed :
                state.isLoading = false
                state.shouldShowOnboarding = false
                // MARK: 메인화면으로
                return .none
                
            case .kakaoLoginTokenNotExist :
                state.shouldShowOnboarding = true
                return .none
                
            case .kakaoLoginErrorOccured :
                state.isLoading = false
                return .none
            }
        }._printChanges()
    }
}
